json.array!(@participant) do |participant|
  json.extract! participant, :id, :identifier, :created_at, :updated_at
  json.url participant_url(participant, format: :json)
end

