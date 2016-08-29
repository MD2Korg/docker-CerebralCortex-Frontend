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
        values.push [datastreamid, Time.at(datapoint_bulk_params(dp)['dateTime']/1000.0).utc.to_datetime, datapoint_bulk_params(dp)['sample'], datapoint_bulk_params(dp)['offset']/60000.0]
      end
      logger.ap 'Array timing: ' + (Time.now-st).to_s, :warn

      Datapoint.transaction do
        Datapoint.import columns, values, validate: false
      end

      logger.ap 'Insert timing: ' + (Time.now-st).to_s, :warn

      prefix=Rails.configuration.database_configuration[Rails.env]['database']

      total_st = Time.now
      params['data'].each_slice(1000) do |subset|
        st = Time.now
        kafka_message = {:datastream_id => datastreamid, :data => subset}
        # logger.ap kafka_message
        message = WaterDrop::Message.new(prefix+'-RAILS-bulkload', kafka_message.to_json)
        message.send!
        logger.ap 'Kafka Message timing: ' + (Time.now-st).to_s
      end
      logger.ap 'All Kafka Message timing: ' + (Time.now-total_st).to_s, :warn


      respond_to do |format|
        msg = {:status => 'ok', :message => 'Successfully loaded datapoints', :count => params['data'].count}
        logger.ap msg, :warn
        format.json { render json: msg }
      end
    else
      respond_to do |format|
        msg = {:status => 'error', :message => 'No data points in array', :count => 0}
        format.json { render json: msg }
      end
    end

  end


  def rawbulkload
    datastreamid = params['datastream_id']

    if datastreamid.present? and Datastream.exists?(id: datastreamid)
      logger.ap 'Processing Datastream: ' + datastreamid.to_s, :warn

      if params['rawdatafile'].present?

        @rawdatafile = params['rawdatafile']
        @rawdata = @rawdatafile.open

        @data = []
        File.open(@rawdata) do |file|
          zio = file
          fail_counter = 0
          loop do

            begin
              io = Zlib::GzipReader.new zio
              io.read.split("\n").each do |entry|
                s = entry.split(',')
                @data.push ({:dateTime => s[0].to_i, :offset => s[1].to_f, :sample => s[2, s.length].map { |n| n.to_f }})
              end

              unused = io.unused
              io.finish
              break if unused.nil?
              zio.pos -= unused.length
            rescue
              # Nothing
              logger.ap 'Corrupt Data Block', :warn
              fail_counter += 1
              if fail_counter > 100
                respond_to do |format|
                  msg = {:status => 'error', :message => 'Unrecoverable data file', :count => 0}
                  format.json { render json: msg }
                end
                return
              end
            end


          end
        end


        prefix=Rails.configuration.database_configuration[Rails.env]['database']
        total_st = Time.now
        @data.each_slice(1000) do |subset|
          st = Time.now
          kafka_message = {:datastream_id => datastreamid, :data => subset}
          # logger.ap kafka_message
          message = WaterDrop::Message.new(prefix+'-RAILS-bulkload', kafka_message.to_json)
          message.send!
          logger.ap 'Kafka Message timing: ' + (Time.now-st).to_s
        end
        logger.ap 'All Kafka Message timing: ' + (Time.now-total_st).to_s, :warn

        respond_to do |format|
          msg = {:status => 'ok', :message => 'Successfully sent rawdatapoints', :count => @data.count}
          logger.ap msg, :warn
          format.json { render json: msg }
        end

      else
        respond_to do |format|
          msg = {:status => 'error', :message => 'No data point file', :count => 0}
          format.json { render json: msg }
        end
      end
    else
      respond_to do |format|
        msg = {:status => 'error', :message => 'Datastream not found', :count => 0}
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

