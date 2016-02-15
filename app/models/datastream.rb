class Datastream < ActiveRecord::Base
  has_one :datasource
  has_one :participant
  belongs_to :datapoint

  def display_name
    self.id.to_s + ':Datasource(' + self.datasource_id.to_s + '):Participant(' + self.participant_id.to_s + ')'
  end
end
