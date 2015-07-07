json.events @events do |event|
  json.(event, :id, :activity, :location, :datetime, :host, :created_at)
end