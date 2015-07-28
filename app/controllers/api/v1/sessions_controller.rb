# app/controllers/api/v1/sessions_controller.rb

class Api::V1::SessionsController < Devise::SessionsController
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
    super do |user|
      render :nothing
    end
  end
end