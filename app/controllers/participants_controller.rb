class ParticipantsController < InheritedResources::Base

  private

    def participant_params
      params.require(:participant).permit(:identifier)
    end
end

