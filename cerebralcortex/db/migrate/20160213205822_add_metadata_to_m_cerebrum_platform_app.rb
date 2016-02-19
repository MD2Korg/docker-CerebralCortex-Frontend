class AddMetadataToMCerebrumPlatformApp < ActiveRecord::Migration
  def change
    add_column :m_cerebrum_platform_apps, :metadata, :jsonb
  end
end
