json.events @events do |event|
  json.(event, :id, :activity, :location, :datetime, :host, :created_at)
end
json.auth_token current_user.auth_token