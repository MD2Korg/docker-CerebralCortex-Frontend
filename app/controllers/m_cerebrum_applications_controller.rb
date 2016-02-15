class MCerebrumApplicationsController < InheritedResources::Base

  def index
    @mcerebrumApplication = MCerebrumApplication.all
  end

  def show
    @mcerebrumApplication = MCerebrumApplication.find(params[:id])
  end

  def create
    @mcapp = MCerebrumApplication.where(identifier: m_cerebrum_application_params['identifier'], applicationtype: m_cerebrum_application_params['applicationtype']).first_or_create(m_cerebrum_application_params)

    respond_to do |format|
      if @mcapp.save
        format.json { render json: @mcapp }
      end
    end
  end

  private

    def m_cerebrum_application_params
      #TWH Removed for JSON API
      # params.require(:m_cerebrum_application).permit(:applicationtype, :identifier, :metadata)
      params.require(:m_cerebrum_application).permit!
    end
end

