class CreateParticipantStudy < ActiveRecord::Migration
  def change
    create_table :participant_studies do |t|
      t.references :participant, index: true, foreign_key: true
      t.references :study, index: true, foreign_key: true
    end
  end
end
