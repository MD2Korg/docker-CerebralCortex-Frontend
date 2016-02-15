class DatasourcesController < InheritedResources::Base

  def index
    @datasource = Datasource.all
  end

  def show
    @datasource = Datasource.find(params[:id])
  end

  private

    def datasource_params
      params.require(:datasource).permit(:identifier, :datasourcetype, :datadescriptor, :metadata)
    end
end

