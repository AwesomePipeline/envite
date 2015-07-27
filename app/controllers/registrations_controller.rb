# app/controllers/registrations_controller.rb

class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  
  def create
    super do |resource|
      # Prevent default redirects
      respond_with resource and return
    end
  end
end