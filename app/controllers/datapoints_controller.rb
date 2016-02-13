class DatapointsController < InheritedResources::Base

  private

    def datapoint_params
      params.require(:datapoint).permit(:timestamp)
    end
end

