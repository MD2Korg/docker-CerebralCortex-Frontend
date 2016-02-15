class MCerebrumPlatformsController < InheritedResources::Base

  def index
    @mcerebrumPlatform = MCerebrumPlatform.all
  end

  def show
    @mcerebrumPlatform = MCerebrumPlatform.find(params[:id])
  end

  private

    def m_cerebrum_platform_params
      params.require(:m_cerebrum_platform).permit(:platformtype, :identifier)
    end
end

