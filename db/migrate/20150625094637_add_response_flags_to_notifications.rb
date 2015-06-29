class AddResponseFlagsToNotifications < ActiveRecord::Migration
  def change
    remove_column :notifications, :response
    
    rename_column :notifications, :suggest_activity, :suggested_activity
    rename_column :notifications, :suggest_datetime, :suggested_datetime
    rename_column :notifications, :suggest_location, :suggested_location
    
    add_column :notifications, :has_responded, :boolean, null: false, default: false
    add_column :notifications, :has_accepted, :boolean, null: false, default: false
    add_column :notifications, :has_suggested_activity, :boolean, null: false, default: false
    add_column :notifications, :has_suggested_datetime, :boolean, null: false, default: false
    add_column :notifications, :has_suggested_location, :boolean, null: false, default: false
  end
end
