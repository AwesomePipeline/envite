json.(
  event,
  :id,
  :activity,
  :location,
  :datetime,
  :description,
  :created_at,
  :updated_at
)
json.host do
  json.partial! 'api/v1/users/user_basic', user: event.user
end