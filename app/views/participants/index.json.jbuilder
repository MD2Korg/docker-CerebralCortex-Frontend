json.array!(@participant) do |participant|
  json.extract! participant, :identifier, :created_at, :updated_at
end

