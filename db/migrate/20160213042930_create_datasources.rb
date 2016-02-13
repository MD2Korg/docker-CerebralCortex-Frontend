class CreateDatasources < ActiveRecord::Migration
  def change
    create_table :datasources do |t|
      t.string :identifier
      t.string :datasourcetype
      t.jsonb :datadescriptor
      t.jsonb :metadata

      t.timestamps null: false
    end
  end
end
