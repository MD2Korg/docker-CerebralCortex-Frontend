json.array!(@datapoint) do |ds|
  json.extract! ds, :created_at, :updated_at, :datastream_id, :timestamp, :sample
end

