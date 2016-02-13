class DatastreamsController < InheritedResources::Base

  private

    def datastream_params
      params.require(:datastream).permit()
    end
end

