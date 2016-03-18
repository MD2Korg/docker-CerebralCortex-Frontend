# == Schema Information
#
# Table name: datapoints
#
#  id            :integer          not null, primary key
#  timestamp     :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  datastream_id :integer
#  sample        :jsonb
#  offset        :integer
#
# Indexes
#
#  index_datapoints_on_datastream_id  (datastream_id)
#
# Foreign Keys
#
#  fk_rails_fc298b36ca  (datastream_id => datastreams.id)
#

class Datapoint < ActiveRecord::Base
  belongs_to :datastream

  scope :datastream, -> (datastream) { where datastream: datastream }
  scope :datastreams, -> (datastreams) { joins(:datastream).where('datastreams.participant_id IN (?)', datastreams) }
  scope :participant, -> (participant) { joins(:datastream).where('datastreams.participant_id = ?', participant) }
  scope :last_window, -> (last_window) { where timestamp: last_window }
end
