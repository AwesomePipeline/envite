class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :event_id, null: false
      t.integer :target, null: false
      
      t.timestamps null: false
    end
  end
end
