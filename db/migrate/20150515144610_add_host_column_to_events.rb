class AddHostColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :host, :integer
  end
end
