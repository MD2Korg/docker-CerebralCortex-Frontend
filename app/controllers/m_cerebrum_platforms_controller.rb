class MCerebrumPlatformsController < InheritedResources::Base

  def index
    @mcerebrumPlatform = MCerebrumPlatform.all
  end

  def show
    @mcerebrumPlatform = MCerebrumPlatform.find(params[:id])
  end

  def create
    @mcplatform = MCerebrumPlatform.new(m_cerebrum_platform_params)

    respond_to do |format|
      if @mcplatform.save
        format.json { render json: @mcplatform }
      end
    end
  end

  private

    def m_cerebrum_platform_params
      #TWH Removed for JSON API
      # params.require(:m_cerebrum_platform).permit(:platformtype, :identifier, :metadata)
      params.require(:m_cerebrum_platform).permit!
    end
end

