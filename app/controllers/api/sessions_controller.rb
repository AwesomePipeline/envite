class Api::SessionsController < Devise::SessionsController
  respond_to :json, :html
  
  prepend_before_filter :require_no_authentication, :only => [:create]
  
  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    respond_to do |format|
      format.html {redirect_to users_path}
      format.json {render status: 200, json: {user: current_user}}
    end
  end
  
  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    sign_out
    render status: 200, json: {:csrfParam => request_forgery_protection_token, :csrfToken => form_authenticity_token}
  end
  
  def require_no_authentication
    assert_is_devise_resource!
    return unless is_navigational_format?
    no_input = devise_mapping.no_input_strategies

    authenticated = if no_input.present?
      args = no_input.dup.push scope: resource_name
      warden.authenticate?(*args)
    else
      warden.authenticated?(resource_name)
    end

    if authenticated && resource = warden.user(resource_name)
      respond_to do |format|
        format.html {
          flash[:alert] = I18n.t("devise.failure.already_authenticated")
          redirect_to after_sign_in_path_for(resource)
        }
        format.json {render status: 409, json: {info: "Already logged in"}}
      end
    end
  end
  
  def failure
    render status: 401, json: {info: "Login failed"}
  end
end