class ContentBlock < ApplicationRecord
  belongs_to :document

  belongs_to :next_block, polymorphic: true, optional: true
  belongs_to :previous_block, polymorphic: true, optional: true

  before_validation :nullify

  def root?
    previous_block_id.nil?
  end

  private

  def nullify
    self.next_block_id = nil unless next_block.present?
    self.previous_block_id = nil unless previous_block.present?

    save
  end
end
