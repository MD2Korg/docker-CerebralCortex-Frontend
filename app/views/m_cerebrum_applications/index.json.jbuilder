json.array!(@mcerebrumApplication) do |mca|
  json.extract! mca, :id, :created_at, :updated_at, :identifier, :applicationtype, :metadata
end

