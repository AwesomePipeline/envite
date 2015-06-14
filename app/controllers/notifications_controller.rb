class NotificationsController < ApplicationController
  protect_from_forgery with: :exception
  respond_to :html
  
  # For forms posted without wrapping model
  wrap_parameters :notification
  
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
  
  def accept
    accept_decline 10, :success, t(:notification_accept_success)
  end
  
  def decline
    accept_decline 20, :success, t(:notification_decline_success)
  end
  
  private
    def accept_decline new_response, flash_type, flash_message
      @notification = Notification.find(params[:id])
      @notification.response = new_response
      @notification.save
      flash[flash_type] = flash_message
      redirect_to :back
    end
  
    def notification_params
      params.permit(:event_id, :target)
    end
end
