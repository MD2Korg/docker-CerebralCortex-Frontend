json.array!(@participants) do |participant|
  json.extract! participant, :id, :identifier
  json.url participant_url(participant, format: :json)
end
