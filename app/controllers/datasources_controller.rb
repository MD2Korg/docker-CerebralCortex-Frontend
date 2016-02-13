class DatasourcesController < InheritedResources::Base

  private

    def datasource_params
      params.require(:datasource).permit(:identifier, :datasourcetype, :datadescriptor, :metadata)
    end
end

