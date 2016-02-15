class DatastreamsController < InheritedResources::Base


  def index
    @datastream = Datastream.all
  end

  def show
    @datastream = Datastream.find(params[:id])
  end

  def create
    @datastream = Datastream.new(datastream_params)

    respond_to do |format|
      if @datastream.save
        format.json { render json: @datastream }
      end
    end
  end

  private

    def datastream_params
      params.require(:datastream).permit(:datasource_id, :participant_id)
    end
end

