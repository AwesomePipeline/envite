# app/controllers/sessions_controller.rb

class SessionsController < Devise::SessionsController
  respond_to :json
  
  def create
    self.resource = warden.authenticate!(auth_options)
    #sign_in(resource_name, resource)
    if signed_in?
      render json: {auth_token: current_user.auth_token}, status: :ok
      sign_out self.resource
    end
  end
  
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out
      head :ok
    else
      head :unauthorized
    end
  end
  
  private
  
  # Override default 'Already signed out' flash and redirect
  def verify_signed_out_user
  end
end