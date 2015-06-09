class Admin::UsersController < ApplicationController
  protect_from_forgery with: :exception
  respond_to :html
  before_filter :check_user_admin
  
  def index
    @users = User.all
    respond_with @users
  end
  
  def show
    @user = User.find(params[:id])
    @events = @user.events
    respond_with(@user, @events)
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = t(:admin_user_create_success)
      redirect_to admin_users_path
    else
      respond_with @user
    end
  end
  
  private
    def user_params
      params.require(:user).permit(
        :email,
        :fullname,
        :handle,
        :password,
        :password_confirmation
      )
    end
    
    def check_user_admin
      if current_user.try(:admin?)
        # Allow action
      else
        flash[:error] = t(:auth_not_authorized_view)
        redirect_to new_user_session_path
      end
    end
end