json.accepted @accepted do |user|
  json.partial! 'api/v1/users/user_basic', user: user
end

json.rejected @rejected do |user|
  json.partial! 'api/v1/users/user_basic', user: user
end