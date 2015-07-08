class Api::V1::EventsController < EventsController
  respond_to :json
  
  def index
    @events = Event.all;
    respond_with @events
  end
  
  def show
    begin
      @event = Event.find(params[:id])
      respond_with @event
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :not_found
    end
  end
end