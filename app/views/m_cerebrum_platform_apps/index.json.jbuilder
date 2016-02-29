json.array!(@mcerebrum_platform_app) do |mca|
  json.extract! mca, :id, :created_at, :updated_at, :identifier, :platformapptype, :metadata
  json.url m_cerebrum_platform_app_url(mca, format: :json)
end

