class AddMetadataToDocument < ActiveRecord::Migration[8.0]
  def change
    add_column :documents, :content, :json
    add_column :documents, :content_html, :text
  end
end
