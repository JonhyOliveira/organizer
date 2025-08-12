class ContentBlock < ApplicationRecord
  belongs_to :document

  belongs_to :next_block, polymorphic: true, optional: true
  belongs_to :previous_block, polymorphic: true, optional: true

  before_validation :nullify
  before_validation :apply_command

  def root?
    previous_block_id.nil?
  end

  def apply_command
  end

  def downgrade!
    raise NotImplementedError
  end

  private

  def nullify
    self.next_block_id = nil unless next_block.present?
    self.previous_block_id = nil unless previous_block.present?
  end
end
