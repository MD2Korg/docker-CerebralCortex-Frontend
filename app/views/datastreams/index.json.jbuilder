json.array!(@datastream) do |ds|
  json.extract! ds, :datasource_id, :participant_id, :created_at, :updated_at
end

