class AddDatasourceToDatastream < ActiveRecord::Migration
  def change
    add_reference :datastreams, :datasource, index: true, foreign_key: true
  end
end
