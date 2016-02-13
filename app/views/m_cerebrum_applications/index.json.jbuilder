json.array!(@m_cerebrum_applications) do |m_cerebrum_application|
  json.extract! m_cerebrum_application, :id, :apptype, :identifier
  json.url m_cerebrum_application_url(m_cerebrum_application, format: :json)
end
