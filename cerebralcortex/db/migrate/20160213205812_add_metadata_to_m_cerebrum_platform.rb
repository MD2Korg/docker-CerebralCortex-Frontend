class AddMetadataToMCerebrumPlatform < ActiveRecord::Migration
  def change
    add_column :m_cerebrum_platforms, :metadata, :jsonb
  end
end
