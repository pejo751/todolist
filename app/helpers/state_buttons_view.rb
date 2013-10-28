class StateButtonsView
  include Rails.application.routes.url_helpers
  include ActionView::Helpers

  def initialize(task)
    @task    = task
    @project = task.project
    @stager  = Stager.new(task)
  end

  def render
    html  = ""
    html << not_start_button << br if @stager.can_trigger?(:not_start)
    html << start_button     << br if @stager.can_trigger?(:start)
    html << complete_button  << br if @stager.can_trigger?(:complete)
    html
  end

protected

  def not_start_button
    link_to 'Not_started',
      stage_change_path(@project.id, @task.id, :not_started), method: :put
  end

  def start_button
    link_to 'Started',
      stage_change_path(@project.id, @task.id, :started), method: :put
  end

  def complete_button
    link_to 'Completed',
      stage_change_path(@project.id, @task.id, :completed), method: :put
  end

  def br
    '<br>'
  end
end
