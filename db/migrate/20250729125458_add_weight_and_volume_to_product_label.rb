class AddWeightAndVolumeToProductLabel < ActiveRecord::Migration[8.0]
  def change
    add_column :product_labels, :weight, :float, null: false
    add_column :product_labels, :volume, :float, null: false
  end
end
