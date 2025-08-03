class ContentBlock < ApplicationRecord
  belongs_to :document

  belongs_to :next_block, polymorphic: true, optional: true
  belongs_to :previous_block, polymorphic: true, optional: true
end
