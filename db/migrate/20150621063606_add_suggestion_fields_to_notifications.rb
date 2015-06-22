class AddSuggestionFieldsToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :suggest_activity, :string, null: true, default: ''
    add_column :notifications, :suggest_datetime, :datetime, null: true
    add_column :notifications, :suggest_location, :string, null: true, default: ''
  end
end
