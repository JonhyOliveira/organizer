class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.text :link
      t.text :name
      t.text :preview_text
      t.text :description
      t.date :date

      t.integer :object_id
      t.text :object_type

      t.timestamps
    end
  end
end
