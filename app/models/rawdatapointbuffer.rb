class Rawdatapointbuffer
  include Cequel::Record

  key :id, :uuid, auto: true
  column :data, :text
end
