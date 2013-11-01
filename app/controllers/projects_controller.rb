class ProjectsController < InheritedResources::Base
  before_action :authenticate_user!

  def new
    @project = current_user.projects.build
    new!
  end

  def create
    @project = build_resource
    @project.user = current_user
    @project.company = current_user.company
    create!
  end

  def destroy
    destroy! { company_projects_url(current_user.company) }
  end

private

  def permitted_params
    params.permit(project: [:name, :description])
  end
end
