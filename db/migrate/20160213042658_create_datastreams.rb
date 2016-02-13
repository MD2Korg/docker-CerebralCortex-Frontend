class CreateDatastreams < ActiveRecord::Migration
  def change
    create_table :datastreams do |t|

      t.timestamps null: false
    end
  end
end
