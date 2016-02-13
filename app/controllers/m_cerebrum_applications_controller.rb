class MCerebrumApplicationsController < InheritedResources::Base

  private

    def m_cerebrum_application_params
      params.require(:m_cerebrum_application).permit(:apptype, :identifier)
    end
end

