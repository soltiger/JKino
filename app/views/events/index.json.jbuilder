json.array!(@events) do |event|
  json.extract! event, :id, :event_name, :event_date
  json.url event_url(event, format: :json)
end
