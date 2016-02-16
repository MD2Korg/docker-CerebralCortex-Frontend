class Datastream < ActiveRecord::Base
  belongs_to :datasource
  belongs_to :participant
  has_many :datapoints

  def display_name
    self.id.to_s + ':Datasource(' + self.datasource_id.to_s + '):Participant(' + self.participant_id.to_s + ')'
  end
end
