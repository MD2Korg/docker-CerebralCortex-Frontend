class RawdatapointsController < InheritedResources::Base
  require 'cassandra'

  @@cequel_config = YAML.load_file("#{Rails.root}/config/cequel.yml")[Rails.env]

  @@cluster = Cassandra.cluster(compression: :lz4)
  @@keyspace = @@cequel_config['keyspace']
  @@session = @@cluster.connect(@@keyspace)
  @@statement = @@session.prepare('INSERT INTO rawdatapoints (datastream, day, dateTime, sample, offset) VALUES (?,?,?,?,?)')


  def bulkload
    datastreamid = rawdatapoint_params['datastream_id']

    if datastreamid.present? and Datastream.exists?(id: datastreamid)

      columns = [:datastream_id, :timestamp, :sample, :offset]

      if params['data'].present?
        totalst = Time.now
        params['data'].each_slice(100) do |subset|
          st = Time.now
          batch = @@session.batch do |b|
            # logger.ap subset.count
            subset.each do |dp|
              b.add(@@statement, [datastreamid, Time.at(rawdatapoint_bulk_params(dp)['dateTime']/1000).utc.strftime('%Y%m%d'), rawdatapoint_bulk_params(dp)['dateTime'], rawdatapoint_bulk_params(dp)['sample'].to_s, rawdatapoint_bulk_params(dp)['offset']/3600000.0])
            end
            #logger.ap "Batch Array timing: " + (Time.now-st).to_s, :warn
          end

          @@session.execute(batch)
          #logger.ap "Batch Insert timing: " + (Time.now-st).to_s + ' Size(' + subset.count.to_s + ')', :warn
        end

        logger.ap "Total Insert timing: " + (Time.now-totalst).to_s, :warn

        respond_to do |format|
          msg = {:status => "ok", :message => 'Successfully loaded rawdatapoints', :count => params['data'].count}
          logger.ap msg, :warn
          format.json { render json: msg }
        end
      else
        respond_to do |format|
          msg = {:status => "error", :message => 'No data points in array', :count => 0}
          format.json { render json: msg }
        end
      end
    else
      respond_to do |format|
        msg = {:status => "error", :message => 'Datastream not found', :count => 0}
        format.json { render json: msg }
      end
    end

  end


  private
  def rawdatapoint_bulk_params(my_params)
    my_params.permit!
  end

  def rawdatapoint_params
    # TWH Temporary to JSON API
    params.require(:rawdatapoint).permit!
  end
end

