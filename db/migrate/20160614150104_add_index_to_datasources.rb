class AddIndexToDatasources < ActiveRecord::Migration
  def change
    add_index :datasources, [:m_cerebrum_application_id, :m_cerebrum_platform_id, :m_cerebrum_platform_app_id], :name => 'datasource_link_index'
  end
end