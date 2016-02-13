json.array!(@datapoints) do |datapoint|
  json.extract! datapoint, :id, :timestamp
  json.url datapoint_url(datapoint, format: :json)
end
