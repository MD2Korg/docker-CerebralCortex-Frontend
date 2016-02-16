class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants, id: :uuid do |t|
      t.string :identifier

      t.timestamps null: false
    end
  end
end
