class ChangeDatapointKeyType < ActiveRecord::Migration
  def up
    change_column :datapoints, :id, :integer, :limit => 8
  end
end
