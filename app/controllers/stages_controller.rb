class StagesController < ApplicationController
  expose(:stager) { Stager.new(task) }

  def update
    process_event
    redirect_to project_tasks_path
  end

protected

  def process_event
    case params[:id]
    when "not_started"
      stager.not_start
    when "started"
      stager.start
    when "completed"
      stager.complete
    else
      flash[:error] = "Invalid state"
    end
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def task
    @task ||= project.tasks.find(params[:task_id])
  end
end
