class AddNameToProductLabel < ActiveRecord::Migration[8.0]
  def change
    add_column :product_labels, :name, :text, null: false
  end
end
