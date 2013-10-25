module TasksHelper

  class StateButtonsView
    # include Rails.application.routes.url_helpers
    include ActionView::Helpers

    def initialize(task)
      @task    = task
      @project = task.project
      @stager  = Stager.new(task)
    end

    def render
      html  = ""
      html << not_start_button if @stager.can_trigger?(:not_start)
      html << start_button     if @stager.can_trigger?(:start)
      html << complete_button  if @stager.can_trigger?(:complete)
      html
    end

  protected

    def not_start_button
      content_tag :button, 'Not started',
        method: :put, class: 'btn-mini'
    end

    def start_button
      # (button_to 'Started',
      #     ActionController::stage_change_path(@project.id, @task.id, :started),
      #       method: :put, class: 'btn-mini').html_safe
      ''
    end

    def complete_button
      # (button_to 'Completed',
      #     ActionController::stage_change_path(@project.id, @task.id, :completed),
      #       method: :put, class: 'btn-mini').html_safe
      ''
    end
  end
end
