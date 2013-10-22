class ProjectsController < InheritedResources::Base

  private

  def permitted_params
      params.permit(
        project: [
          :name, :description
        ]
      )
  end
end
