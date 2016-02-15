class ParticipantsController < InheritedResources::Base

  def index
    @participant = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def create
    @participant = Participant.new(participant_params)

    respond_to do |format|
      if @participant.save
        format.json { render json: @participant }
      end
    end
  end

  private

    def participant_params
      params.require(:participant).permit(:identifier)
    end
end

