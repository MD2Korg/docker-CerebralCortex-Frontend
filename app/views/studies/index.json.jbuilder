json.array!(@study) do |s|
  json.extract! s, :id, :identifier, :name, :created_at, :updated_at
  json.url study_url(s, format: :json)
end

