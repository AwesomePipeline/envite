# app/controllers/api/v1/registrations_controller.rb

class Api::V1::RegistrationsController < Devise::RegistrationsController
  before_filter :authenticate_user_from_token!, only: [:show, :update]
  before_filter :authenticate_user!, only: [:show, :update]
  respond_to :json
  
  def create
    super do |resource|
      # Prevent default redirects
      respond_with resource and return
    end
  end
  
  def show
  end
  
  def update
    begin
      @user = User.find(params[:id])
      if !@user.update(user_params)
        render json: {errors: @user.errors}, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render nothing: true, status: :not_found
    end
  end
  
  protected
  
  def user_params
    params.require(:user).permit(
      :fullname,
      :username,
      :password,
      :password_confirmation
    )
  end
end