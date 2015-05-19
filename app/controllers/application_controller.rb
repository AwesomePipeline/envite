class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from(ActionController::ParameterMissing) do |e|
    error = {}
    error[e.param] = ["parameter is missing"]
    response = {errors: [error]}
    respond_to do |format|
      format.json {render json: response, status: :unprocessable_entity}
    end
  end
end
