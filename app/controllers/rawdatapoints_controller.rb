class RawdatapointsController < InheritedResources::Base

  @@instance = RawdatapointsController.new

  def self.instance
    @@instance
  end

  def initialize
    require 'cassandra'
    @@cequel_config = YAML.load_file("#{Rails.root}/config/cequel.yml")[Rails.env]

    @@cluster = Cassandra.cluster(compression: :lz4, hosts: @@cequel_config['hosts'], username: @@cequel_config['username'], password: @@cequel_config['password'])
    @@keyspace = @@cequel_config['keyspace']
    @@session = @@cluster.connect(@@keyspace)
    @@statement = @@session.prepare('INSERT INTO rawdatapointbuffers (id, data) VALUES (?, ?)')
    @@generator = Cassandra::Uuid::Generator.new
  end

  def bulkload
    datastreamid = rawdatapoint_params['datastream_id']

    if datastreamid.present? and Datastream.exists?(id: datastreamid)

      if params['data'].present?
        st = Time.now
        futures = @@session.execute_async(@@statement, arguments: [@@generator.at(Time.now().utc.to_f), params['data'].to_s])
        logger.ap "Batch Array timing: " + (Time.now-st).to_s, :warn
        futures.join
        logger.ap "Batch Insert timing: " + (Time.now-st).to_s, :warn


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

