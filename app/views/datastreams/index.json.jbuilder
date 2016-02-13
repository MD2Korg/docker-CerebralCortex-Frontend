json.array!(@datastreams) do |datastream|
  json.extract! datastream, :id
  json.url datastream_url(datastream, format: :json)
end
