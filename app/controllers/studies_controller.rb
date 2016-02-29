class StudiesController < InheritedResources::Base

  @participants = Participant.all

  def index
    @study = Study.all
  end

  def show
    @study = Study.find(params[:id])
  end

  def create
    @study = Study.where(identifier: study_params['identifier']).first_or_create(study_params)

    respond_to do |format|
      if @study.save
        format.json { render json: @study }
      end
    end
  end

  def register_participant
    register_params = registerParticipant_params(params)

    @participant_study = ParticipantStudy.where(participant_id: register_params['participant_id'], study_id: register_params['study_id'])
                            .first_or_create(:participant_id => register_params['participant_id'], :study_id => register_params['study_id'])

    respond_to do |format|
      if @participant_study.save
        format.json { render json: @participant_study }
      end
    end

  end

  private
  def registerParticipant_params(my_params)
    my_params.permit!
  end

  def study_params
    params.require(:study).permit(:identifier, :name, :participant_ids => [])
  end
end

