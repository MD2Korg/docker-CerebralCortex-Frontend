class DatasourcesController < InheritedResources::Base

  def index
    @datasource = Datasource.all
  end

  def show
    @datasource = Datasource.find(params[:id])
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
    participant_id = parameters['participant_id']

    application = parameters['datasource']['application']
    platform = parameters['datasource']['platform']
    platformapp = parameters['datasource']['platformapp']

    @mcapplication = MCerebrumApplication.where(identifier: application['id'], applicationtype: application['type'])
                         .first_or_create(:identifier => application['id'], :applicationtype => application['type'], :metadata => application['metadata'])
    @mcplatform = MCerebrumPlatform.where(identifier: platform['id'], platformtype: platform['type'])
                      .first_or_create(:identifier => platform['id'], :platformtype => platform['type'], :metadata => platform['metadata'])
    @mcplatformapp = MCerebrumPlatformApp.where(identifier: platformapp['id'], platformapptype: platformapp['type'])
                         .first_or_create(:identifier => platformapp['id'], :platformapptype => platformapp['type'], :metadata => platformapp['metadata'])

    ds = parameters['datasource']
    @datasource = Datasource.where(identifier: ds['id'], datasourcetype: ds['type'])
                      .first_or_create(:identifier => ds['id'],
                                       :datasourcetype => ds['type'],
                                       :datadescriptor => ds['datadescriptor'],
                                       :metadata => ds['metadata'],
                                       :m_cerebrum_application_id => @mcapplication.id,
                                       :m_cerebrum_platform_id => @mcplatform.id,
                                       :m_cerebrum_platform_app_id => @mcplatformapp.id
                      )

    @datastream = Datastream.where(participant_id: participant_id, datasource_id: @datasource.id).first_or_create(participant_id: participant_id, datasource_id: @datasource.id)
    logger.info @datastream.inspect

    respond_to do |format|
      msg = {:status => "ok", :message => 'Successfully loaded datasource', :datasource_id => @datasource.id.to_s}
      format.json { render json: msg }
    end

  end

  private

  def datasource_register_params(my_params)
    my_params.permit!
  end

  def datasource_params
      # TWH: Temporary to the the API working
      # params.require(:datasource).permit(:identifier, :datasourcetype, :datadescriptor, :metadata)
      params.require(:datasource).permit!
    end
end

