class MCerebrumPlatformAppsController < InheritedResources::Base

  def index
    @mcerebrumPlatformApp = MCerebrumPlatformApp.all
  end

  def show
    @mcerebrumPlatformApp = MCerebrumPlatformApp.find(params[:id])
  end

  def create
    @mcplatformapp = MCerebrumPlatformApp.where(identifier: m_cerebrum_platform_app_params['identifier'], platformapptype: m_cerebrum_platform_app_params['platformapptype']).first_or_create(m_cerebrum_platform_app_params)

    respond_to do |format|
      if @mcplatformapp.save
        format.json { render json: @mcplatformapp }
      end
    end
  end

  private

    def m_cerebrum_platform_app_params
      #TWH Removed for JSON API
      #params.require(:m_cerebrum_platform_app).permit(:platformapptype, :identifier)
      params.require(:m_cerebrum_platform_app).permit!
    end
end

