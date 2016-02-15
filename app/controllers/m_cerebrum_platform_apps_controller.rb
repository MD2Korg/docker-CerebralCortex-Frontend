class MCerebrumPlatformAppsController < InheritedResources::Base

  def index
    @mcerebrumPlatformApp = MCerebrumPlatformApp.all
  end

  def show
    @mcerebrumPlatformApp = MCerebrumPlatformApp.find(params[:id])
  end

  private

    def m_cerebrum_platform_app_params
      params.require(:m_cerebrum_platform_app).permit(:platformapptype, :identifier)
    end
end

