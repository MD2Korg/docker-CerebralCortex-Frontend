class MCerebrumPlatformsController < InheritedResources::Base

  private

    def m_cerebrum_platform_params
      params.require(:m_cerebrum_platform).permit(:platformtype, :identifier)
    end
end

