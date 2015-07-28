# app/controllers/sessions_controller.rb

class SessionsController < Devise::SessionsController
  respond_to :json
  
  def create
    super do |user|
      data = {
        token: user.auth_token,
        username: user.username
      }
      render json: data, status: 201 and return
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