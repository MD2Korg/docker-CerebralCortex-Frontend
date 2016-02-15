json.array!(@study) do |s|
  json.extract! s, :id, :identifier, :name, :created_at, :updated_at
end

