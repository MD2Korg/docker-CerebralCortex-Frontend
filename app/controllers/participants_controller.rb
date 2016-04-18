class ParticipantsController < InheritedResources::Base

  def index
    @participant = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def create
    @participant = Participant.where(id: participant_params['id']).first_or_create(participant_params)
    logger.ap @participant, :warn
    # @participant.save
    # respond_with  @participant
    respond_to do |format|
      if @participant.save
        format.json { render json: @participant }
      end
    end

  end

  private
  def participant_params
    params.require(:participant).permit(:identifier, :id, :study_ids => [])
  end
end

