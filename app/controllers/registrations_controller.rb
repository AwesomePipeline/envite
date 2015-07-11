# app/controllers/registrations_controller.rb

class RegistrationsController < Devise::RegistrationsController
  clear_respond_to # Prevent views from rendering
  
  respond_to :json
end