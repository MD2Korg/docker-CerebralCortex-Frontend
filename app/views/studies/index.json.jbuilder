json.array!(@study) do |s|
  json.extract! s, :identifier, :name, :created_at, :updated_at
end

