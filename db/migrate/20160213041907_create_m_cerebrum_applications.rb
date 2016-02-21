class CreateMCerebrumApplications < ActiveRecord::Migration
  def change
    create_table :m_cerebrum_applications do |t|
      t.string :apptype
      t.string :identifier

      t.timestamps null: false
    end
  end
end
