class CreateMCerebrumPlatformApps < ActiveRecord::Migration
  def change
    create_table :m_cerebrum_platform_apps do |t|
      t.string :platformapptype
      t.string :identifier

      t.timestamps null: false
    end
  end
end
