class AddSortIndexToContentBlocks < ActiveRecord::Migration[8.0]
  def change
    add_reference :content_blocks, :previous_block, index: false, polymorphic: true
    add_reference :content_blocks, :next_block, index: false, polymorphic: true

    add_column :content_blocks, :sort_index, :integer
    add_index :content_blocks, [ :document_id, :sort_index ], unique: true
  end
end
