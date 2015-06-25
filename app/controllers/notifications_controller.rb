class NotificationsController < ApplicationController
  protect_from_forgery with: :exception
  respond_to :html
  
  def user_index  
    @notifications = Notification.where(target: current_user.id)
  end
  
  def create
    @notification = Notification.where(event_id: params[:event_id], target: params[:target])
    if @notification.empty?
      @notification = Notification.new(notification_params)
      if @notification.save
        flash[:notice] = "Friend invited"
        redirect_to :back
      else
        flash[:error] = "Unable to invite friend"
        redirect_to :back
      end
    else
      flash[:error] = "That friend is already invited"
      redirect_to :back
    end
  end
  
  # Accept / Decline event invitations
  def accept
    set_response 'accept'
  end
  
  def decline
    set_response 'reject'
  end
  
  # Forms to suggest alternative activity, datetime or location
  def suggest_activity
    @notification = Notification.find(params[:id])
  end
  
  def suggest_datetime
    @notification = Notification.find(params[:id])
  end
  
  def suggest_location
    @notification = Notification.find(params[:id])
  end
  
  # Handling of suggestions
  def suggest
    set_response params[:notification][:suggest_type]
  end
  
  private
    # Sets the appropriate response flags and redirects to :back
    # Defined in: notifications_controller.rb
    def set_response response_type
      @notification = Notification.find(params[:id])
      
      case response_type
      when 'accept'
        @notification.has_responded = true
        @notification.has_accepted = true
        flash[:success] = t(:notification_accept_success)
      when 'reject'
        @notification.has_responded = true
        @notification.has_accepted = false
        flash[:success] = t(:notification_reject_success)
      when 'activity'
        @notification.has_suggested_activity = true
        @notification.suggested_activity = params[:notification][:suggested_activity]
        flash[:success] = t(:notification_suggest_success)
      when 'datetime'
        @notification.has_suggested_datetime = true
        @notification.suggested_datetime = datetime_from_params(params[:notification][:suggested_datetime])
        flash[:success] = t(:notification_suggest_success)
      when 'location'
        @notification.has_suggested_location = true
        @notification.suggested_location = params[:notification][:suggested_location]
        flash[:success] = t(:notification_suggest_success)
      else
        flash[:error] = t(:notification_suggest_type_error)
        redirect_to :back and return
      end
      
      if !@notification.save!
        flash[:success] = nil
        flash[:error] = t(:notification_suggest_error)
      end
      
      redirect_to :back
    end
    
    def notification_params
      params.require(:notification).permit(:event_id, :target)
    end
end
