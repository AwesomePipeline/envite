class ChangeEventsToUseUuid < ActiveRecord::Migration
  def change
    change_column :events, :id, :string, null: false
  end
end
