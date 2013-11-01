class ProjectsController < InheritedResources::Base
  before_action :authenticate_user!

  def new
    @project = current_user.projects.build
    new!
  end

  def create
    @project = build_resource
    @project.user = current_user
    @project.company = current_company
    create!
  end

  def destroy
    destroy! { projects_url }
  end

  def index
    @projects = current_company.projects
    index!
  end

private

  def permitted_params
    params.permit(project: [:name, :description])
  end
end
