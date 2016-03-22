class DatapointsController < InheritedResources::Base

  def index
    @datapoint = Datapoint.all
  end

  def show
    @datapoint = Datapoint.find(datapoint_params[:id])
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
    columns = [:datastream_id, :timestamp, :sample, :offset]

    if params['data'].present? and datastreamid.present?
      st = Time.now

      values = []
      params['data'].map do |dp|
        values.push [datastreamid, Time.at(datapoint_bulk_params(dp)['dateTime']/1000.0).utc.to_datetime, datapoint_bulk_params(dp)['sample'], datapoint_bulk_params(dp)['offset']/3600000.0]
      end
      logger.ap "Array timing: " + (Time.now-st).to_s, :warn

      Datapoint.transaction do
        Datapoint.import columns, values, validate: false
      end

      logger.ap "Insert timing: " + (Time.now-st).to_s, :warn


      respond_to do |format|
        msg = {:status => "ok", :message => 'Successfully loaded datapoints', :count => params['data'].count}
        logger.ap msg, :warn
        format.json { render json: msg }
      end
    else
      respond_to do |format|
        msg = {:status => "error", :message => 'No data points in array', :count => 0}
        format.json { render json: msg }
      end
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

