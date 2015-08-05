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
  
  def accept
    set_response 'accept'
  end
  
  def decline
    set_response 'reject'
  end
  
  def suggest
    set_response params[:notification][:suggest_type]
  end
  
  private
  
  def get_notification
    begin
      @notification = Notification.where(target: current_user.id, event_id: params[:id])
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :not_found
    end
  end
  
  def set_response response_type
    begin
      @notification = Notification.where(target: current_user.id, event_id: params[:id])
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :not_found
    end
    
    case response_type
    when 'accept'
      @notification.has_responded = true
      @notification.has_accepted = true
    when 'reject'
      @notification.has_responded = true
      @notification.has_accepted = false
    when 'activity'
      @notification.has_suggested_activity = true
      @notification.suggested_activity = params[:notification][:suggested_activity]
    when 'datetime'
      @notification.has_suggested_datetime = true
      @notification.suggested_datetime = datetime_from_params(params[:notification][:suggested_datetime])
    when 'location'
      @notification.has_suggested_location = true
      @notification.suggested_location = params[:notification][:suggested_location]
    else
      render nothing: true, status: :unprocessable_entity
    end
    
    if @notification.save
      render nothing: true, status: :ok
    else
      render nothing: true, status: :unprocessable_entity
    end
  end
  
  def notification_params
  end
  
end