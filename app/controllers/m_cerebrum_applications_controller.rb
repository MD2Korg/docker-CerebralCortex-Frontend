class MCerebrumApplicationsController < InheritedResources::Base

  def index
    @mcerebrumApplication = MCerebrumApplication.all
  end

  def show
    @mcerebrumApplication = MCerebrumApplication.find(params[:id])
  end


  private

    def m_cerebrum_application_params
      params.require(:m_cerebrum_application).permit(:apptype, :identifier)
    end
end

