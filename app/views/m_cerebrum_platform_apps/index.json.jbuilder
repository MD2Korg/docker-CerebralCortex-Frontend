json.array!(@m_cerebrum_platform_apps) do |m_cerebrum_platform_app|
  json.extract! m_cerebrum_platform_app, :id, :platformapptype, :identifier
  json.url m_cerebrum_platform_app_url(m_cerebrum_platform_app, format: :json)
end
