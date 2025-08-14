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

ActiveRecord::Schema[8.0].define(version: 2025_08_14_094310) do
  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "agenda_items", force: :cascade do |t|
    t.integer "parent_agenda_item_id"
    t.integer "document_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "do_by_start"
    t.datetime "do_by_end"
    t.string "status", default: "todo", null: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["document_id"], name: "index_agenda_items_on_document_id"
    t.index ["parent_agenda_item_id"], name: "index_agenda_items_on_parent_agenda_item_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "content"
    t.text "content_html"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "agenda_items", "agenda_items", column: "parent_agenda_item_id", on_delete: :nullify
  add_foreign_key "agenda_items", "documents"
end
