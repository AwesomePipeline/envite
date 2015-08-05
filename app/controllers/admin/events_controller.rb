class Admin::EventsController < EventsController
  respond_to :html
  
  def index
    @events = Event.all
    respond_with(@events)
  end
  
  def new
    @event = Event.new
    respond_with(@event)
  end
  
end