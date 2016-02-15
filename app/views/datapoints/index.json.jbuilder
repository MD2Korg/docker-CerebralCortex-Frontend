json.array!(@datapoint) do |ds|
  json.extract! ds, :id, :created_at, :updated_at, :datastream_id, :timestamp, :sample
end

