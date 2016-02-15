json.array!(@participant) do |participant|
  json.extract! participant, :id, :identifier, :created_at, :updated_at
end

