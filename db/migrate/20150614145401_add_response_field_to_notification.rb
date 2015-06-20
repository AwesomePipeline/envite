class AddResponseFieldToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :response, :integer, null: false, default: 0
  end
end
