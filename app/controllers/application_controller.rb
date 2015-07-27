# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, :if => :devise_controller?
  
  # Returns a datetime object from specified key in params
  def datetime_from_params params, model, key
    begin
      year = params[model.to_s][key.to_s+'(1i)'].to_i
      mth = params[model.to_s][key.to_s+'(2i)'].to_i
      day = params[model.to_s][key.to_s+'(3i)'].to_i
      hour = params[model.to_s][key.to_s+'(4i)'].to_i
      min = params[model.to_s][key.to_s+'(5i)'].to_i
      sec = params[model.to_s][key.to_s+'(6i)'].to_i
      
      DateTime.new(year, mth, day, hour, min, sec)
    rescue e
      nil
    end
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:fullname, :username, :password, :password_confirmation)
    end
    
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:fullname, :username, :password, :password_confirmation, :current_password)
    end
  end
  
  private
  
  def authenticate_user_from_token!
    username = params[:username]
    user = username && User.find_by_username(username)
    logger.info "[ApplicationController] Logging in user: " + user.inspect
    if user && Devise.secure_compare(user.auth_token, params[:auth_token])
      sign_in user
    end
  end
end
