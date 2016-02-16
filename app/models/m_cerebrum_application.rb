# == Schema Information
#
# Table name: m_cerebrum_applications
#
#  id              :integer          not null, primary key
#  applicationtype :string
#  identifier      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  metadata        :jsonb
#

class MCerebrumApplication < ActiveRecord::Base
  has_many :datasource

  def display_name
    self.id.to_s + ':' + self.identifier + " (" + self.applicationtype + ")"
  end
end
