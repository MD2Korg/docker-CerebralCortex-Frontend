json.array!(@datasource) do |ds|
  json.extract! ds, :id, :created_at, :updated_at, :identifier, :datasourcetype, :datadescriptor, :metadata, :m_cerebrum_application_id, :m_cerebrum_platform_id, :m_cerebrum_platform_app_id
  json.url datasource_url(ds, format: :json)
end

