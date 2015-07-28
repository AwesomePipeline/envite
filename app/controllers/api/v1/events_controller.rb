# app/controllers/api/v1/events_controller.rb

class Api::V1::EventsController < EventsController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  respond_to :json
  
  def user_index
    @events = Event.where(host: current_user.id)
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