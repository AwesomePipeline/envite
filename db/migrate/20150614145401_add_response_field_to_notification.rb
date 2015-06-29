class AddResponseFieldToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :response, :integer, null: false, default: 0b1000_0000
  end
end
