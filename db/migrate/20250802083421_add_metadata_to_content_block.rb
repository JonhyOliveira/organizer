class AddMetadataToContentBlock < ActiveRecord::Migration[8.0]
  def change
    add_column :content_blocks, :metadata, :json
  end
end
