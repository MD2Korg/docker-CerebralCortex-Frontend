# == Schema Information
#
# Table name: participants
#
#  id         :uuid             not null, primary key
#  identifier :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participant < ActiveRecord::Base
  has_many :participantStudies
  has_many :studies, through: :participantStudies

  def display_name
    self.identifier.to_s + ' (' + self.id.to_s + ')'
  end
end
