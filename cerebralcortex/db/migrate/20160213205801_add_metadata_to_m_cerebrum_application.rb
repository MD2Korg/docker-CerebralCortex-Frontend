class AddMetadataToMCerebrumApplication < ActiveRecord::Migration
  def change
    add_column :m_cerebrum_applications, :metadata, :jsonb
  end
end
