class Stager
  def initialize(task)
    @task = task
  end

  def not_start
    sm.trigger(:not_start)
    @task.save
  end

  def start
    sm.trigger(:start)
    @task.save
  end

  def complete
    sm.trigger(:complete)
    @task.save
  end

  def can_trigger?(event)
    sm.trigger?(event)
  end

private

  def sm
    @sm ||= begin
      psm = MicroMachine.new(@task.state || "not_started")

      psm.when(:not_start,
        "started"     => "not_started",
        "completed"   => "not_started"
      )
      psm.when(:start,
        "not_started" => "started",
        "completed"   => "started"
      )
      psm.when(:complete,
        "not_started" => "completed",
        "started"     => "completed"
      )

      psm.on "not_started" do
        @task.started_on = nil
        @task.completed_on = nil
      end

      psm.on "started" do
        @task.started_on = Date.today
        @task.completed_on = nil
      end

      psm.on "completed" do
        @task.completed_on = Date.today
      end

      psm.on(:any) do
        @task.state = sm.state
      end

      psm
    end
  end
end
