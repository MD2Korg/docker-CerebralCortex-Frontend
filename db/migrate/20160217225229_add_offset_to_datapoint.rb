class AddOffsetToDatapoint < ActiveRecord::Migration
  def change
    add_column :datapoints, :offset, :integer
  end
end
