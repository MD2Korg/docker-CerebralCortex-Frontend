class AddParticipantToDatastream < ActiveRecord::Migration
  def change
    add_reference :datastreams, :participant, index: true, foreign_key: true
  end
end
