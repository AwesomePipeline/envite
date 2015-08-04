# app/controllers/api/v1/notifications_controller.rb

class Api::V1::NotificationsController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!
  respond_to :json
  
  def create
    @notification = Notification.new(event_id: params[:id], target: current_user.id)
    if @notification.save
      render 'create', status: :created
    else
      render json: {errors: @notification.errors}, status: :unprocessable_entity
    end
  end
  
  private
  
  def notification_params
  end
  
end