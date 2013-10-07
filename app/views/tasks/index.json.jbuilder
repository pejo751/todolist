json.array!(@tasks) do |task|
  json.extract! task, :name, :programmer, :project, :priority, :notes, :budget, :start_date, :due_date, :progress, :status
  json.url task_url(task, format: :json)
end
