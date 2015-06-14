class Admin::EventsController < EventsController
  
  def index
    @events = Event.all
    respond_with(@events)
  end
  
  def new
    @event = Event.new
    @users = User.all
  end
  
end
