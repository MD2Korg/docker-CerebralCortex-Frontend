class StudiesController < InheritedResources::Base

  def index
    @study = Study.all
  end

  def show
    @study = Study.find(params[:id])
  end

  def create
    @study = Study.new(study_params)

    respond_to do |format|
      if @study.save
        format.json { render json: @study }
      end
    end
  end

  private
    def study_params
      params.require(:study).permit(:identifier, :name)
    end
end

