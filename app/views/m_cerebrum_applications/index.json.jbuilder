json.array!(@mcerebrumApplication) do |mca|
  json.extract! mca, :id, :created_at, :updated_at, :identifier, :applicationtype, :metadata
  json.url m_cerebrum_application_url(mca, format: :json)
end

