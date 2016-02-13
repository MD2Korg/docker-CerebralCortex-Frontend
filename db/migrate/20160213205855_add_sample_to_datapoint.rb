class AddSampleToDatapoint < ActiveRecord::Migration
  def change
    add_column :datapoints, :sample, :jsonb
  end
end
