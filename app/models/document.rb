class Document < ApplicationRecord
  class NoSingleRootError < StandardError
    attr_accessor :document_id, :roots_count

    def initialize(document_id, roots_count)
      super("Can't create a chain when there isn't a single root")
      @document_id = document_id
      @roots_count = roots_count
    end
  end

  has_many :content_blocks, inverse_of: :document, autosave: true do
    def sorted
      order(:sort_index).where.not(sort_index: nil)
    end

    def roots
      where(previous_block: nil)
    end

    def out_of_chain
      where.not(id: chain.pluck(:id))
    end

    def chain
      chain = []

      raise NoSingleRootError.new(self.ids, roots.count) if roots.count != 1

      root = roots.first
      current = root
      index = 0

      loop do
        chain << current

        yield current, index if block_given?

        break if current.next_block.nil?
        current = current.next_block
        index += 1
      end

      chain
    end
  end

  validates_presence_of :title

  def name
    self.title
  end

  def build_empty_span
    content_blocks.build(type: ContentBlock::Span)
  end

  def sanitize!
    if content_blocks.none?
      cb = build_empty_span
      cb.sort_index = 0
      cb.save!
    end

    if content_blocks.count == 1
      root = content_blocks.first
      root.next_block = nil
      root.previous_block = nil
    else
      content_blocks.chain.reverse.each_with_index do |content_block, index|
        break if content_block.root? || content_block.text_content.present?
        content_block.destroy!
        Rails.logger.info "Removed empty trailing content block from document"
      end
    end
  end

  def add_content_block(new_content_block, reference_content_block, placement: :after)
    placement = placement.to_sym unless placement.is_a? Symbol

    changed_blocks = []

    case placement.to_sym
    when :after
      # change links to be: reference_content_block - new_content_block - reference_next_block
      reference_next_block = reference_content_block.next_block
      reference_content_block.next_block = new_content_block
      new_content_block.previous_block = reference_content_block
      new_content_block.next_block = reference_next_block
      reference_next_block.previous_block = new_content_block if reference_next_block.present?
      changed_blocks += [ reference_content_block, new_content_block, reference_next_block ]
    when :before
      # change links to be: reference_before_block - new_content_block - reference_content_block
      reference_before_block = reference_content_block.previous_block
      reference_content_block.previous_block = new_content_block
      new_content_block.next_block = reference_content_block
      new_content_block.previous_block = reference_before_block
      reference_before_block.next_block = new_content_block if reference_before_block.present?
      changed_blocks += [ reference_before_block, new_content_block, reference_content_block ]
    else
      raise "Invalid placement"
    end

    changed_blocks.compact.each(&:save!)

    resort_from(new_content_block)

    save
  end

  def remove_content_block(content_block)
    content_block.previous_block.next_block = content_block.next_block if content_block.previous_block.present?
    content_block.next_block.previous_block = content_block.previous_block if content_block.next_block.present?

    if content_block.previous_block.present?
      resort_from(content_block.previous_block)
    elsif content_block.next_block.present?
      resort_from(content_block.next_block)
    end

    content_block.destroy

    save
  end

  class LoopDetectedError < StandardError
    attr_accessor :visited_blocks, :error_block

    def initialize(visited_blocks, error_block)
      super("Loop detected")
      @visited_blocks = visited_blocks
      @error_block = error_block
    end
  end

  def resort_from(content_block)
    ApplicationRecord.transaction do
      visited_content_block = false
      content_blocks_to_save = []

      content_blocks.chain do |cb, i|
        visited_content_block = true if content_block == cb
        next unless visited_content_block

        cb.sort_index = i
        content_blocks_to_save << cb
      end

      content_blocks_to_save.reverse.each(&:save!)
    end
  end
end
