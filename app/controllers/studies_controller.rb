class StudiesController < InheritedResources::Base

  def index
    @study = Study.all
  end

  def show
    @study = Study.find(params[:id])
  end


  private
    def study_params
      params.require(:study).permit(:identifier, :name)
    end
end

