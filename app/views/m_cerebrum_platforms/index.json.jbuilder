json.array!(@mcerebrumPlatform) do |mca|
  json.extract! mca, :id, :created_at, :updated_at, :identifier, :platformtype, :metadata
end

