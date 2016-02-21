# == Schema Information
#
# Table name: participant_studies
#
#  id             :integer          not null, primary key
#  participant_id :uuid
#  study_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_participant_studies_on_participant_id  (participant_id)
#  index_participant_studies_on_study_id        (study_id)
#
# Foreign Keys
#
#  fk_rails_a427dc1be7  (participant_id => participants.id)
#  fk_rails_acbc1a23cd  (study_id => studies.id)
#

class ParticipantStudy < ActiveRecord::Base
  belongs_to :participant
  belongs_to :study
end
