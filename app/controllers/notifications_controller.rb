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
        flash[:info] = "Friend invited"
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
  
  private
    def notification_params
      params.permit(:event_id, :target)
    end
end
