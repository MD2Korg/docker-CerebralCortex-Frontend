json.array!(@mcerebrumPlatformApp) do |mca|
  json.extract! mca, :created_at, :updated_at, :identifier, :platformapptype, :metadata
end

