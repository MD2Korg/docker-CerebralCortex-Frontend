class ParticipantsController < InheritedResources::Base

  def index
    @participant = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])
  end

  private

    def participant_params
      params.require(:participant).permit(:identifier)
    end
end

