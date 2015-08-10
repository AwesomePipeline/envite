# app/controllers/api/v1/events_controller.rb

class Api::V1::EventsController < EventsController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  respond_to :json
  
  def user_index
    @events = Event.where(host: current_user.id)
  end
  
  def user_invited_index
    notifications = Notification.where(target: current_user.id)
    @events = Event.where(id: notifications.pluck(:event_id))
  end
  
  def show
    begin
      @event = Event.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :not_found
    end
  end
  
  def create
    @event = Event.new(event_params)
    if !@event.save
      render json: {errors: @event.errors}, status: :unprocessable_entity
    end
  end
  
  def update
    begin
      @event = Event.find(params[:id])
      if !@event.update(event_params)
        render json: {errors: @event.errors}, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :not_found
    end
  end
  
  def responses
    begin
      @event = Event.find(params[:id])
      @accepted = User.find(Notification.where(event: @event, has_responded: true, has_accepted: true).pluck(:target))
      @rejected = User.find(Notification.where(event: @event, has_responded: true, has_accepted: false).pluck(:target))
      @not_responded = User.find(Notification.where(event: @event, has_responded: false).pluck(:target))
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :not_found
    end
  end
  
  protected
  
  def event_params
    params[:event].merge!(host: current_user.id)
    params.require(:event).permit(
      :activity,
      :datetime,
      :location,
      :description,
      :host
    )
  end
end
