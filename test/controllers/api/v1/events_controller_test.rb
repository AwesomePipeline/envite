require 'test_helper'

class Api::V1::EventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  
  test "event create route unauthorized" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    post :create
    assert_response :unauthorized
  end
  
end