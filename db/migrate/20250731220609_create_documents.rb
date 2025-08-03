class CreateDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :description
      t.string :contents

      t.timestamps
    end
  end
end
