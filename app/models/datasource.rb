class Datasource < ActiveRecord::Base
  belongs_to :m_cerebrum_application
  belongs_to :m_cerebrum_platform
  belongs_to :m_cerebrum_platform_app
  has_one :datastream

  def display_name
    self.id.to_s + ':' + self.identifier + " (" + self.datasourcetype + ")"
  end
end
