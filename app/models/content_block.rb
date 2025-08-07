class ContentBlock < ApplicationRecord
  belongs_to :document

  belongs_to :next_block, polymorphic: true, optional: true
  belongs_to :previous_block, polymorphic: true, optional: true

  attr_accessor :is_placeholder

  def text_content
    metadata || ""
  end

  def root?
    previous_block_id.nil?
  end
end
