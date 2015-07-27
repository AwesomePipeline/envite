class UsersOptionalFullname < ActiveRecord::Migration
  def change
    change_column :users, :fullname, :string, null: true
  end
end
