class TasksController < InheritedResources::Base

  belongs_to :project

  def create
    create! { collection_url }
  end

  def update
    update! { collection_url }
  end

  def main
    @tasks = Task.all
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def resource_params
    params.require(:task).permit(
      :name, :programmer, :priority, :notes, :budget, :start_date, :due_date,
      :status, :project_id, :kind
    )
  end
end
