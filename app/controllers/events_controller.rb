class EventsController < ApplicationController
  protect_from_forgery with: :exception
  respond_to :html
  
  def index
    @events = Event.all
    respond_with(@events)
  end
  
  def user_index
    @events = Event.where(host: current_user.id)
    respond_with(@events)
  end
  
  def show
    @event = Event.find(params[:id])
    @invited = User.joins(:notifications).where(notifications: {event: @event})
    @others = User.where.not(id: @invited.pluck(:id) << current_user.id)
    respond_with @event, @users, @others
  end
  
  def new
    @event = Event.new
    @users = User.all
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def create
    @event = Event.new(event_params)
    
    # Check that the host is the current user if user is not an admin
    # TODO: May not allow this for admin also
    if !current_user.admin? && params[:event][:host] != current_user.id
      flash[:error] = t(:event_create_error_host_mismatch)
    else
      @event.save
    end
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
  
  protected
    def event_params
      # Merge in host's user id for non-admin users
      if !current_user.admin?
        params[:event].merge!(host: current_user.id)
      end
      
      params.require(:event).permit(
        :activity,
        :datetime,
        :location,
        :description,
        :host
      )
    end
end
