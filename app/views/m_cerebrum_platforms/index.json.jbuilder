json.array!(@mcerebrum_platform) do |mca|
  json.extract! mca, :id, :created_at, :updated_at, :identifier, :platformtype, :metadata
  json.url m_cerebrum_platform_url(mca, format: :json)
end

