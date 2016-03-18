class AddIndexToDatapoints < ActiveRecord::Migration
  def change
    add_index :datapoints, :timestamp
  end
end
