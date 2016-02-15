json.array!(@datasource) do |ds|
  json.extract! ds, :created_at, :updated_at, :identifier, :datasourcetype, :datadescriptor, :metadata, :m_cerebrum_application_id, :m_cerebrum_platform_id, :m_cerebrum_platform_app_id
end

