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


  def bulkload
    datastreamid = datapoint_params['datastream_id']

    data = params['data'].map do |dp|
      dp['datastream_id'] = datastreamid
      Datapoint.new(datapoint_bulk_params(dp))
    end

    Datapoint.import data

    respond_to do |format|
      msg = {:status => "ok", :message => 'Successfully loaded datapoints', :number => params['data'].count}
      format.json { render json: msg }
    end

  end

  private
  def datapoint_bulk_params(my_params)
    my_params.permit!
  end

    def datapoint_params
      # TWH Temporary to JSON API
      # params.require(:datapoint).permit(:datastream_id, :timestamp, :sample)
      params.require(:datapoint).permit!
    end
end

