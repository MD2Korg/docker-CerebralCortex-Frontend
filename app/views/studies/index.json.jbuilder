json.array!(@studies) do |study|
  json.extract! study, :id, :identifier, :name
  json.url study_url(study, format: :json)
end
