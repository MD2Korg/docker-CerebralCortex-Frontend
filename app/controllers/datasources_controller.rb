class DatasourcesController < InheritedResources::Base

  def index
    @datasource = Datasource.all
  end

  def show
    @datasource = Datasource.find(params[:id])
  end


  def create
    @datasource = Datasource.new(datasource_params)

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

