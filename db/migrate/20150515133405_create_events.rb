class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :activity
      t.datetime :datetime
      t.string :location
      t.string :description

      t.timestamps null: false
    end
  end
end
