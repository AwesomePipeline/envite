class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :event_id, null: false
      t.integer :user_id, null: false
      t.string :message, null: false
      t.timestamps null: false
    end
  end
end
