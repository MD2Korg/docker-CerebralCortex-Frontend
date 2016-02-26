# == Schema Information
#
# Table name: datastreams
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  datasource_id  :integer
#  participant_id :uuid
#
# Indexes
#
#  index_datastreams_on_datasource_id   (datasource_id)
#  index_datastreams_on_participant_id  (participant_id)
#
# Foreign Keys
#
#  fk_rails_2c9d94efa2  (participant_id => participants.id)
#  fk_rails_7fdf2c6e3e  (datasource_id => datasources.id)
#

class Datastream < ActiveRecord::Base
  belongs_to :datasource
  belongs_to :participant
  has_many :datapoints

  def display_name
    self.datasource.display_name + ' - ' + self.participant.display_name + ' (' +self.id.to_s + ')'
  end
end
