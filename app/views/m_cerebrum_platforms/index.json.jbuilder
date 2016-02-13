json.array!(@m_cerebrum_platforms) do |m_cerebrum_platform|
  json.extract! m_cerebrum_platform, :id, :platformtype, :identifier
  json.url m_cerebrum_platform_url(m_cerebrum_platform, format: :json)
end
