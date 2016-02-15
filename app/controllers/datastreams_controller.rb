class DatastreamsController < InheritedResources::Base


  def index
    @datastream = Datastream.all
  end

  def show
    @datastream = Datastream.find(params[:id])
  end


  private

    def datastream_params
      params.require(:datastream).permit()
    end
end

