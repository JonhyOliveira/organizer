class CreateAgendaItems < ActiveRecord::Migration[8.0]
  def change
    create_table :agenda_items do |t|
      t.references :parent_agenda_item, foreign_key: { to_table: :agenda_items, on_delete: :nullify }, index: true
      t.references :document, null: false, foreign_key: true

      t.datetime :start_time
      t.datetime :end_time

      t.datetime :do_by_start
      t.datetime :do_by_end

      t.string :status, null: false, default: "todo"
      t.datetime :completed_at

      t.timestamps
    end
  end
end
