class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :type, null: false
      t.string :details, null: false
      t.timestamps null: false
    end
  end
end
