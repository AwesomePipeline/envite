class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  
  # Returns a datetime object from specified key in params
  def datetime_from_params params, model, key
    begin
      year = params[model.to_s][key.to_s+'(1i)'].to_i
      mth = params[model.to_s][key.to_s+'(2i)'].to_i
      day = params[model.to_s][key.to_s+'(3i)'].to_i
      hour = params[model.to_s][key.to_s+'(4i)'].to_i
      min = params[model.to_s][key.to_s+'(5i)'].to_i
      sec = params[model.to_s][key.to_s+'(6i)'].to_i
      
      DateTime.new(year, mth, day, hour, min, sec)
    rescue e
      nil
    end
  end
end
