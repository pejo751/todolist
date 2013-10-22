class Task < ActiveRecord::Base

  before_save :persist_status

  KINDS = ['Back End', 'Front End', 'Testing', 'Estimation']
  PRIORITIES = ['Low', 'Normal', 'High']
  STATUSES = ['Not started','Started','Completed']

  belongs_to :project
  delegate :name, to: :project, prefix: true

  validates :name, :programmer, :project_id, :priority, :kind, :status,
    presence: true
  validates :priority, inclusion: { in: PRIORITIES }
  validates :budget, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: STATUSES }
  validates :kind, inclusion: { in: KINDS }

  default_value_for :budget, 0.0
  default_value_for :priority, PRIORITIES.first
  default_value_for :status, STATUSES.first
  default_value_for :kind,  KINDS.first

  def not_started
    set_status.trigger(:not_started)
  end

  def started
    set_status.trigger(:started)
  end

  def completed
    set_status.trigger(:completed)
  end

  def set_status
    @set_status ||= begin
      fsm = MicroMachine.new(status || STATUSES.first)

      fsm.when(:not_started, STATUSES[1] => STATUSES.first,
        STATUSES[2] => STATUSES.first)
      fsm.on :not_started do
        self.started_on = nil
        self.expired_on = nil
      end

      fsm.when(:started, STATUSES.first => STATUSES[1],
        STATUSES[2] => STATUSES[1])
      fsm.on :started do
        self.started_on = Date.today
      end

      fsm.when(:completed, STATUSES.first => STATUSES[2],
        STATUSES[1] => STATUSES[2])
      fsm.on :started do
        self.expired_on = Date.today
      end

      fsm
    end
  end

  private

  def persist_status
    self.status = set_status.state
  end
end
