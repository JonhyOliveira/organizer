class ReplaceContentsWithContentLines < ActiveRecord::Migration[8.0]
  def change
    remove_column :documents, :contents, :string
  end
end
