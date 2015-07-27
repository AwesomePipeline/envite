class EventsController < ApplicationController
  
  def user_index
    @events = Event.where(host: current_user.id)
    respond_with(@events)
  end
  
  def show
    @event = Event.find(params[:id])
    respond_with @event
  end
  
  def new
    @event = Event.new
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
  
  # Shows all friends and allow host to invite friends to event
  def invite
    @event = Event.find(params[:id])
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
