class ProjectsController < InheritedResources::Base

  expose(:projects)
  expose(:project)

private

  def permitted_params
      params.permit(project: [:name, :description])
  end
end
