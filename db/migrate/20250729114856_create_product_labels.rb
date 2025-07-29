class CreateProductLabels < ActiveRecord::Migration[8.0]
  def change
    create_table :product_labels do |t|
      t.float :energy, null: false
      t.float :fats, null: false
      t.float :saturated_fats, null: false
      t.float :carbohydrates, null: false
      t.float :sugar_carbohydrates, null: false
      t.float :protein, null: false
      t.float :salt, null: false
      t.json :vitamins, null: false
      t.json :ingredients, null: false
      t.text :baseline_type, null: false
      t.float :baseline, null: false

      t.timestamps
    end

    add_index :product_labels, :baseline_type
  end
end
