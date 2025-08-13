class DropContentBlocks < ActiveRecord::Migration[8.0]
  def change
    drop_table :content_blocks
  end
end
