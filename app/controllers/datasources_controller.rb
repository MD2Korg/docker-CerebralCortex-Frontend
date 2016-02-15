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

  private

    def datasource_params
      # TWH: Temporary to the the API working
      # params.require(:datasource).permit(:identifier, :datasourcetype, :datadescriptor, :metadata)
      params.require(:datasource).permit!
    end
end

