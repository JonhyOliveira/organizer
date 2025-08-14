class RemoveStatusColumnFromAgendaItems < ActiveRecord::Migration[8.0]
  def change
    remove_column :agenda_items, :status, :string
    remove_column :agenda_items, :completed_at, :datetime
  end
end
