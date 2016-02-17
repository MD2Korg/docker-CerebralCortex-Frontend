json.extract! @study, :identifier, :name, :created_at, :updated_at

json.participants @study.participants do |s|
  json.id s.id
  json.identifier s.identifier
end
