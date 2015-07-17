class UsersController < ApplicationController
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