# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_02_154537) do
  create_table "content_blocks", force: :cascade do |t|
    t.integer "document_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.json "metadata"
    t.string "previous_block_type"
    t.integer "previous_block_id"
    t.string "next_block_type"
    t.integer "next_block_id"
    t.integer "sort_index"
    t.index ["document_id", "sort_index"], name: "index_content_blocks_on_document_id_and_sort_index", unique: true
    t.index ["document_id"], name: "index_content_blocks_on_document_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_labels", force: :cascade do |t|
    t.float "energy", null: false
    t.float "fats", null: false
    t.float "saturated_fats", null: false
    t.float "carbohydrates", null: false
    t.float "sugar_carbohydrates", null: false
    t.float "protein", null: false
    t.float "salt", null: false
    t.json "vitamins", null: false
    t.json "ingredients", null: false
    t.text "baseline_type", null: false
    t.float "baseline", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "name", null: false
    t.float "weight", null: false
    t.float "volume", null: false
    t.index ["baseline_type"], name: "index_product_labels_on_baseline_type"
  end

  add_foreign_key "content_blocks", "documents"
end
