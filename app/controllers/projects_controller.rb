class ProjectsController < InheritedResources::Base

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    params.require(:project).permit(:name, :description)
  end
end
