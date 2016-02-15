json.array!(@mcerebrumPlatformApp) do |mca|
  json.extract! mca, :id, :created_at, :updated_at, :identifier, :platformapptype, :metadata
end

