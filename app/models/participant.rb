# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  identifier :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participant < ActiveRecord::Base
  has_many :datastream
  has_and_belongs_to_many :studies

  def display_name
    self.id.to_s + ':' + self.identifier
  end
end
