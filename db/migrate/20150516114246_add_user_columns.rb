class AddUserColumns < ActiveRecord::Migration
  def change
    add_column :users, :fullname, :string
    add_column :users, :handle, :string
    add_column :users, :email, :string
  end
end
