class TasksController < InheritedResources::Base

  belongs_to :project

  def create
    create! { collection_url }
  end

  def update
    update! { collection_url }
  end

private

  def permitted_params
      params.permit(
        task: [:name, :programmer, :priority, :notes, :budget, :kind]
      )
  end
end
