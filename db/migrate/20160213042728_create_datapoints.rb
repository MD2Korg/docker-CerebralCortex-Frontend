class CreateDatapoints < ActiveRecord::Migration
  def change
    create_table :datapoints do |t|
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end
