json.accepted @accepted do |user|
  json.partial! 'api/v1/users/user_basic', user: user
end

json.rejected @rejected do |user|
  json.partial! 'api/v1/users/user_basic', user: user
end

json.not_responded @not_responded do |user|
  json.partial! 'api/v1/users/user_basic', user: user
end

json.suggested_activities @suggested_activities do |notification|
  json.partial! 'api/v1/users/user_basic', user: notification.user
  json.set! :data, notification.suggested_activity
end

json.suggested_locations @suggested_locations do |notification|
  json.partial! 'api/v1/users/user_basic', user: notification.user
  json.set! :data, notification.suggested_location
end

json.suggested_datetimes @suggested_datetimes do |notification|
  json.partial! 'api/v1/users/user_basic', user: notification.user
  json.set! :data, (notification.suggested_datetime - 8.hours)
end