class LandingController < ApplicationController
  def index
    flash[:notice] = "Testing flash messages"
  end
end
