class CreateMCerebrumPlatforms < ActiveRecord::Migration
  def change
    create_table :m_cerebrum_platforms do |t|
      t.string :platformtype
      t.string :identifier

      t.timestamps null: false
    end
  end
end
