class Rawdatapoint
  include Cequel::Record

  key :datastream, :int, {partition: true}
  key :day, :text, {partition: true}
  key :dateTime, :bigint
  column :offset, :float
  column :sample, :text
end
