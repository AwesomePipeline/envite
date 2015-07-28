# app/controllers/api/v1/registrations_controller.rb

class Api::V1::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  
  def create
    super do |resource|
      # Prevent default redirects
      respond_with resource and return
    end
  end
end