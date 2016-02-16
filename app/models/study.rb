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
  has_and_belongs_to_many :participants

  def display_name
    self.id.to_s + ':' + self.identifier
  end
end
