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

  def display_name
    self.id.to_s + ':' + self.identifier.to_s + " (" + self.platformtype.to_s + ")"
  end
end
