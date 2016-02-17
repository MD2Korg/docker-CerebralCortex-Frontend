class CreateParticipantStudies < ActiveRecord::Migration
  def change
    create_table :participant_studies do |t|
      t.references :participant, type: :uuid, index: true, foreign_key: true
      t.references :study, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
