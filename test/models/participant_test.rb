require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "can have empty identifier" do
    participant = Participant.new
    assert_nil participant.identifier
  end

end
