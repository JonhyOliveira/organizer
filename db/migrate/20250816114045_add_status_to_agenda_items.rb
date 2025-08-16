class AddStatusToAgendaItems < ActiveRecord::Migration[8.0]
  def change
    add_column :agenda_items, :status, :string
  end
end
