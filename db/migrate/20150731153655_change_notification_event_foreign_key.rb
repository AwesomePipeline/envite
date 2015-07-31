class ChangeNotificationEventForeignKey < ActiveRecord::Migration
  def change
    change_column :notifications, :event_id, :string
  end
end
