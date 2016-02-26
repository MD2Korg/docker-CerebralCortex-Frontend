# == Schema Information
#
# Table name: m_cerebrum_platform_apps
#
#  id              :integer          not null, primary key
#  platformapptype :string
#  identifier      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  metadata        :jsonb
#

class MCerebrumPlatformApp < ActiveRecord::Base
  has_many :datasource

  def display_name
    self.platformapptype.to_s + " (" + self.identifier.to_s + ") [" + self.id.to_s + ']'
  end
end
