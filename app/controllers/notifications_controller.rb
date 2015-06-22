class NotificationsController < ApplicationController
  protect_from_forgery with: :exception
  respond_to :html
  include NotificationsHelper
  
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
    set_response_code :accept
    flash[:success] = t(:notification_accept_success)
    redirect_to :back
  end
  
  def decline
    set_response_code :reject
    flash[:success] = t(:notification_reject_success)
    redirect_to :back
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
    @notification = Notification.find(params[:id])
    
    case params[:notification][:suggest_type]
    when 'activity'
      @notification.suggest_activity = params[:notification][:suggest_activity]
    when 'datetime'
      @notification.suggest_datetime = datetime_from_params(params, :notification, :suggest_datetime)
    when 'location'
      @notification.suggest_location = params[:notification][:suggest_location]
    else
      flash[:error] = t(:notification_suggest_type_error)
    end
    
    if @notification.save!
      flash[:success] = t(:notification_suggest_success)
    else
      flash[:error] = t(:notification_suggest_error)
    end
    
    redirect_to :back
  end
  
  private
    def set_response_code response_type
      @notification = Notification.find(params[:id])
      @notification.response = set_response(@notification.response, response_type)
      @notification.save!
    end
    
    def notification_params
      params.require(:notification).permit(:event_id, :target)
    end
end
