class Datasource < ActiveRecord::Base
  has_one :m_cerebrum_application
  has_one :m_cerebrum_platform
  has_one :m_cerebrum_platform_app
  belongs_to :datastream
end
