class MCerebrumPlatformAppsController < InheritedResources::Base

  private

    def m_cerebrum_platform_app_params
      params.require(:m_cerebrum_platform_app).permit(:platformapptype, :identifier)
    end
end

