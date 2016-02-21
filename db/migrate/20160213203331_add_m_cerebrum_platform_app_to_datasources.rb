class AddMCerebrumPlatformAppToDatasources < ActiveRecord::Migration
  def change
    add_reference :datasources, :m_cerebrum_platform_app, index: true, foreign_key: true
  end
end
