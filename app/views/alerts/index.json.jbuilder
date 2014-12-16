json.array!(@alerts) do |alert|
  json.extract! alert, :id, :description
  json.url alert_url(alert, format: :json)
end
