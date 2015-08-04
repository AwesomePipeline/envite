# test/integration/routes_test.rb
require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  
  test "event routes" do
    assert_recognizes({
      format: :json,
      controller: 'api/v1/events',
      action: 'create',
    }, {
      path: 'api/v1/user/events',
      method: 'post'
    }, nil, '[route] API POST Create Event')
    
    assert_recognizes({
      format: :json,
      controller: 'api/v1/events',
      action: 'show',
      id: '12345'
    }, {
      path: 'api/v1/user/events/12345',
      method: 'get'
    }, nil, '[route] API GET Show Event')
    
    assert_recognizes({
      format: :json,
      controller: 'api/v1/events',
      action: 'update',
      id: '12345'
    }, {
      path: 'api/v1/user/events/12345',
      method: 'put'
    }, nil, '[route] API PUT Update Event')
    
    assert_recognizes({
      format: :json,
      controller: 'api/v1/events',
      action: 'user_index',
    }, {
      path: 'api/v1/user/events',
      method: 'get'
    }, nil, '[route] API GET User Events Index')
    
    assert_recognizes({
      format: :json,
      controller: 'api/v1/events',
      action: 'user_invited_index',
    }, {
      path: 'api/v1/user/events/invited',
      method: 'get'
    }, nil, '[route] API GET User Invited Events')
  end
  
end