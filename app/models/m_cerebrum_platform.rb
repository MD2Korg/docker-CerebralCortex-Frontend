# == Schema Information
#
# Table name: m_cerebrum_platforms
#
#  id           :integer          not null, primary key
#  platformtype :string
#  identifier   :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  metadata     :jsonb
#

class MCerebrumPlatform < ActiveRecord::Base
  has_many :datasource

  scope :query, -> (platform_type, identifier) { where(platformtype: platform_type, identifier: identifier) }
  scope :query_identifier, -> (identifier) { where(identifier: identifier) }
  def display_name
    self.platformtype.to_s + " (" + self.identifier.to_s + ") [" + self.id.to_s + ']'
  end
end
