class Users::RegistrationsController < Api::RegistrationsController
  protect_from_forgery with: :exception
  respond_to :html
end