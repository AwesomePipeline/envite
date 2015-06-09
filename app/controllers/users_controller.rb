class UsersController < ApplicationController
  protected
    def user_params
      params.require(:user).permit(
        :email,
        :fullname,
        :handle,
        :password,
        :password_confirmation
      )
    end
end