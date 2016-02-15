class Datasource < ActiveRecord::Base
  has_one :m_cerebrum_application
  has_one :m_cerebrum_platform
  has_one :m_cerebrum_platform_app
  belongs_to :datastream

  def display_name
    self.id.to_s + ':' + self.identifier + " (" + self.datasourcetype + ")"
  end
end
