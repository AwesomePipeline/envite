class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :html, :json
  
  def index
    @users = User.all
    respond_with(@users)
  end
  
  def show
    @user = User.find(params[:id])
    @events = @user.events
    respond_with(@user)
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    
    @user.save
    respond_with(@user)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html {redirect_to users_path}
      format.json {render json: {}, status: :ok}
    end
  end
  
  private
    def user_params
      params.require(:user).permit(
      :fullname, :email, :handle)
    end
end
