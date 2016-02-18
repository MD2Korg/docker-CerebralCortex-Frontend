json.array!(@datapoint) do |ds|
  json.extract! ds, :id, :created_at, :updated_at, :datastream_id, :timestamp, :offset, :sample,
                json.url datapoint_url(ds, format: :json)
end

