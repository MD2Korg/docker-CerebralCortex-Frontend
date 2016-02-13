json.array!(@datasources) do |datasource|
  json.extract! datasource, :id, :identifier, :datasourcetype, :datadescriptor, :metadata
  json.url datasource_url(datasource, format: :json)
end
