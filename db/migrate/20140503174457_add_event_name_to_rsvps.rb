class AddEventNameToRsvps < ActiveRecord::Migration
  def change
    add_column :rsvps, :event_name, :string
  end
end
