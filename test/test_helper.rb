ENV['RAILS_ENV'] ||= 'test'

# Set up SimpleCov
require 'simplecov'
SimpleCov.start 'rails'

require 'coveralls'
Coveralls.wear! 'rails'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end
