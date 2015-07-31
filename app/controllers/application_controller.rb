# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
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
  
  # Authenticates the user from token obtained via API authentication
  def authenticate_user_from_token!
    logger.info "authenticating user"
    authenticate_with_http_token do |token, options|
      username = options[:username].presence
      user = username && User.find_by_username(username)
      logger.info "username: " + username
      logger.info "user: " + user.inspect
      logger.info "token: " + token
      logger.info "user_token: " + user.auth_token
      if user && Devise.secure_compare(user.auth_token, token)
        sign_in user, store: false
        logger.info "current_user: " + current_user.inspect
      else
        logger.error "login failed"
      end
    end
  end
  
  rescue_from(ActionController::ParameterMissing) do |e|
    error = {}
    error[e.param] = ["parameter is missing"]
    response = {errors: [error]}
    respond_to do |format|
      format.json {render json: response, status: :unprocessable_entity}
    end
  end
  
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      logger.info "handling CORS pre-flight"
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Authorization, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end
end
