json.accepted @accepted do |user|
  json.partial! 'api/v1/users/user_basic', user: user
end

json.rejected @rejected do |user|
  json.partial! 'api/v1/users/user_basic', user: user
end

json.not_responded @not_responded do |user|
  json.partial! 'api/v1/users/user_basic', user: user
end

json.suggested_activities @suggested_activities do |key, notifications|
  json.set! key do
    json.array! notifications do |notification|
      json.partial! 'api/v1/users/user_basic', user: notification.user
    end
  end
end

json.suggested_locations @suggested_location do |key, notifications|
  json.set! key do
    json.array! notifications do |notification|
      json.partial! 'api/v1/users/user_basic', user: notification.user
    end
  end
end

json.suggested_datetimes @suggested_datetime do |key, notifications|
  json.set! key do
    json.array! notifications do |notification|
      json.partial! 'api/v1/users/user_basic', user: notification.user
    end
  end
end