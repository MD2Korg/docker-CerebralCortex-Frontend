class AddDatasourceTomCerebrumPlatform < ActiveRecord::Migration
  def change
    add_reference :datasources, :m_cerebrum_platform, index: true, foreign_key: true
  end
end
