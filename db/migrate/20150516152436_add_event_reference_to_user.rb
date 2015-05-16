class AddEventReferenceToUser < ActiveRecord::Migration
  def change
    change_column :events, :host, :user
  end
end
