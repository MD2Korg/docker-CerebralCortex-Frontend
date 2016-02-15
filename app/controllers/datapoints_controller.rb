class DatapointsController < InheritedResources::Base

  def index
    @datapoint = Datapoint.all
  end

  def show
    @datapoint = Datapoint.find(params[:id])
  end

  private

    def datapoint_params
      params.require(:datapoint).permit(:timestamp)
    end
end

