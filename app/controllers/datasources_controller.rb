class DatasourcesController < InheritedResources::Base

  def index
    @datasource = Datasource.all
  end

  def show
    @datasource = Datasource.find(datasource_params[:id])
  end


  def create
    @datasource = Datasource.where(identifier: datasource_params['identifier'],
                                   datasourcetype: datasource_params['datasourcetype'],
                                   m_cerebrum_application_id: datasource_params['m_cerebrum_application_id'],
                                   m_cerebrum_platform_id: datasource_params['m_cerebrum_platform_id'],
                                   m_cerebrum_platform_app_id: datasource_params['m_cerebrum_platform_app_id']
    ).first_or_create(datasource_params)

    respond_to do |format|
      if @datasource.save
        format.json { render json: @datasource }
      end
    end
  end



  def register
    parameters = datasource_register_params(params)
    parameters = deep_stringify_keys(parameters)

    participant_id = parameters['participant_id']

    application = parameters['datasource']['application']
    platform = parameters['datasource']['platform']
    platformapp = parameters['datasource']['platformapp']

    if application.present?
      @mcapplication = MCerebrumApplication.where(identifier: application['id'], applicationtype: application['type'], metadata: [application['metadata']])
                           .first_or_create(:identifier => application['id'], :applicationtype => application['type'], :metadata => application['metadata'])
    else
      @mcapplication = MCerebrumApplication.where(identifier: nil, applicationtype: nil).first_or_create(:identifier => nil, :applicationtype => nil)
    end

    if platform.present?
      @mcplatform = MCerebrumPlatform.where(identifier: platform['id'], platformtype: platform['type'], metadata: [platform['metadata']])
                        .first_or_create(:identifier => platform['id'], :platformtype => platform['type'], :metadata => platform['metadata'])
    else
      @mcplatform = MCerebrumPlatform.where(identifier: nil, platformtype: nil).first_or_create(:identifier => nil, :platformtype => nil)
    end

    if platformapp.present?
      @mcplatformapp = MCerebrumPlatformApp.where(identifier: platformapp['id'], platformapptype: platformapp['type'], metadata: [platformapp['metadata']])
                           .first_or_create(:identifier => platformapp['id'], :platformapptype => platformapp['type'], :metadata => platformapp['metadata'])
    else
      @mcplatformapp = MCerebrumPlatformApp.where(identifier: nil, platformapptype: nil).first_or_create(:identifier => nil, :platformapptype => nil)
    end

    ds = parameters['datasource']

    if ds['dataDescriptors'].nil?
      ds['dataDescriptors'] = []
    end
    if ds['metadata'].nil?
      ds['metadata'] = {}
    end

    @datasource = Datasource.exists(ds['id'],
                                    ds['type'],
                                    ds['dataDescriptors'].to_json,
                                    ds['metadata'].to_json,
                                    @mcapplication.id,
                                    @mcplatform.id,
                                    @mcplatformapp.id)
                      .first_or_create(:identifier => ds['id'],
                                       :datasourcetype => ds['type'],
                                       :datadescriptor => ds['dataDescriptors'].to_json,
                                       :metadata => ds['metadata'].to_json,
                                       :m_cerebrum_application_id => @mcapplication.id,
                                       :m_cerebrum_platform_id => @mcplatform.id,
                                       :m_cerebrum_platform_app_id => @mcplatformapp.id
                      )

    @datastream = Datastream.where(participant_id: participant_id, datasource_id: @datasource.id).first_or_create(participant_id: participant_id, datasource_id: @datasource.id)

    respond_to do |format|
      msg = {:status => "ok", :message => 'Successfully loaded datasource', :datastream_id => @datastream.id.to_s}
      logger.ap msg
      format.json { render json: msg }
    end

  end

  private

  def transform_hash(original, options={}, &block)
    original.inject({}) { |result, (key, value)|
      value = if (options[:deep] && Hash === value)
                transform_hash(value, options, &block)
              else
                value
              end
      block.call(result, key, value)
      result
    }
  end

  def deep_stringify_keys(hash)
    transform_hash(hash, :deep => true) { |hash, key, value|
      if value.instance_of? String
        hash[key] = value.force_encoding("ISO-8859-1").encode("UTF-8")
      else
        hash[key] = value
      end
    }
  end

  def datasource_register_params(my_params)
    my_params.permit!
  end

  def datasource_params
    # TWH: Temporary to the the API working
    # params.require(:datasource).permit(:identifier, :datasourcetype, :datadescriptor, :metadata)
    params.require(:datasource).permit!
  end
end

