class Document < ApplicationRecord

  class NoSingleRootError < StandardError
    attr_accessor :document_id, :roots_count

    def initialize(document_id, roots_count)
      super("Can't create a chain when there isn't a single root")
      @document_id = document_id
      @roots_count = roots_count
    end
  end

  SEARCH_INDEX = "documents_search_index"
  TABLE_NAME = "documents"

  scope :search, ->(query) do
    joins("join #{SEARCH_INDEX} idx on #{TABLE_NAME}.id = idx.rowid")
    .where("#{SEARCH_INDEX} match ?", query)
  end

  scope :with_snippets, ->(**options) do
    select("#{TABLE_NAME}.*")
    .select_snippet("title", 0, **options)
    .select_snippet("description", 1, **options)
  end

  has_many :content_blocks, inverse_of: :document do
    def sorted
      order(:sort_index)
    end

    def roots
      where(previous_block: nil)
    end

    def out_of_chain
      where.not(id: chain.pluck(:id))
    end

    def chain
      chain = []

      raise NoSingleRootError.new(self.id, roots.count) if roots.count != 1

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

  after_create_commit  :create_in_search_index
  after_update_commit  :update_in_search_index
  after_destroy_commit :remove_from_search_index

  def name
    self.title
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

  def update_in_search_index
    transaction do
      remove_from_search_index
      create_in_search_index
    end
  end

  private

  def create_in_search_index
    execute_sql_with_binds "insert into #{SEARCH_INDEX} (rowid, title, description) values (?, ?, ?)", id, title, description
  end

  def remove_from_search_index
    execute_sql_with_binds "insert into #{SEARCH_INDEX} (#{SEARCH_INDEX}, rowid, title, description) values ('delete', ?, ?, ?)", id_previously_was, title_previously_was, description_previously_was
  end

  def execute_sql_with_binds(*statement)
    self.class.connection.execute self.class.sanitize_sql(statement)
  end

  def self.select_snippet(column, offset, tag: "mark", omission: "…", limit: 32)
    select("snippet(#{SEARCH_INDEX}, #{offset}, '<#{tag}>', '</#{tag}>', '#{omission}', #{limit}) AS #{column}_snippet")
  end
end
