class AddIndexToDataPoints < ActiveRecord::Migration
  def change
    add_index :datapoints, [:datastream_id, :timestamp]
  end
end