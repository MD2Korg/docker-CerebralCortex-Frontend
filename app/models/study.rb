# == Schema Information
#
# Table name: studies
#
#  id         :integer          not null, primary key
#  identifier :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Study < ActiveRecord::Base
  has_many :participantStudies
  has_many :participants, through: :participantStudies


  def display_name
    self.identifier.to_s + ' (' + self.id.to_s + ')'
  end
end
