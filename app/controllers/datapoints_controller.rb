class DatapointsController < InheritedResources::Base

  def index
    @datapoint = Datapoint.all
  end

  def show
    @datapoint = Datapoint.find(params[:id])
  end

  def create
    @dp = Datapoint.new(datapoint_params)

    respond_to do |format|
      if @dp.save
        format.json { render json: @dp }
      end
    end
  end

  private

    def datapoint_params
      # TWH Temporary to JSON API
      # params.require(:datapoint).permit(:datastream_id, :timestamp, :sample)
      params.require(:datapoint).permit!
    end
end

