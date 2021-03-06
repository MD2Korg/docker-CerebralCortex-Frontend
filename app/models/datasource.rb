# == Schema Information
#
# Table name: datasources
#
#  id                         :integer          not null, primary key
#  identifier                 :string
#  datasourcetype             :string
#  datadescriptor             :jsonb
#  metadata                   :jsonb
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  m_cerebrum_application_id  :integer
#  m_cerebrum_platform_id     :integer
#  m_cerebrum_platform_app_id :integer
#
# Indexes
#
#  index_datasources_on_m_cerebrum_application_id   (m_cerebrum_application_id)
#  index_datasources_on_m_cerebrum_platform_app_id  (m_cerebrum_platform_app_id)
#  index_datasources_on_m_cerebrum_platform_id      (m_cerebrum_platform_id)
#
# Foreign Keys
#
#  fk_rails_03f1d65a1a  (m_cerebrum_application_id => m_cerebrum_applications.id)
#  fk_rails_6cd0b6fef5  (m_cerebrum_platform_id => m_cerebrum_platforms.id)
#  fk_rails_bcd516299c  (m_cerebrum_platform_app_id => m_cerebrum_platform_apps.id)
#

class Datasource < ActiveRecord::Base
  belongs_to :m_cerebrum_application
  belongs_to :m_cerebrum_platform
  belongs_to :m_cerebrum_platform_app
  has_one :datastream

  def display_name
    self.datasourcetype.to_s + " (" + self.identifier.to_s + ") [" + self.id.to_s + ']'
  end

  scope :query, -> (datasource_type, id) { where(datasourcetype: datasource_type, identifier: id) }
  scope :query_plat_id, -> (datasource_type, platform_identifier) { where(datasourcetype: datasource_type, m_cerebrum_platform_id: MCerebrumPlatform.query_identifier(platform_identifier)) }

  def self.exists(id, type, dd, meta, mcapp, mcplat, mcplatapp)
    where(identifier: id,
          datasourcetype: type,
          datadescriptor: dd,
          metadata: meta,
          m_cerebrum_application_id: mcapp,
          m_cerebrum_platform_id: mcplat,
          m_cerebrum_platform_app_id: mcplatapp)
  end

end
