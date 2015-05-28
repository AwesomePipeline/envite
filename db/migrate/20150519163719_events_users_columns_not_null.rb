class EventsUsersColumnsNotNull < ActiveRecord::Migration
  def change
    change_column_null :events, :activity, false
    change_column_null :events, :datetime, false
    change_column_null :events, :location, false
    
    change_column_null :events, :description, false
    change_column_default :events, :description, ""
      
    change_column_null :events, :host, false
    
    change_column_null :users, :fullname, false
    change_column_null :users, :handle, false
  end
end
