class RemoveEmailFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :email
    rename_column :users, :handle, :username
  end
end
