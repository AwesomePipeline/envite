class EventsController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :html, :json
  
  def index
    @events = Event.all
    respond_with(@events)
  end
  
  def show
    @event = Event.find(params[:id])
    respond_with(@event)
  end
  
  def new
    @event = Event.new
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def create
    @event = Event.new(event_params)
    
    @event.save
    respond_with(@event)
  end
  
  def update
    @event = Event.find(params[:id])
      
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    redirect_to events_path
  end
  
  private
    def event_params
      params.require(:event).permit(
      :activity, :datetime, :location, :description, :host)
    end
end
