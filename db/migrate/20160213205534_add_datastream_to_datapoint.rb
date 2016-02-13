class AddDatastreamToDatapoint < ActiveRecord::Migration
  def change
    add_reference :datapoints, :datastream, index: true, foreign_key: true
  end
end
