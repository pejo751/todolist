class Task < ActiveRecord::Base

  KINDS = ['Back End', 'Front End', 'Testing', 'Estimation']
  PRIORITIES = ['Low', 'Normal', 'High']

  belongs_to :project
  delegate :name, to: :project, prefix: true

  validates :name, :programmer, :project_id, :priority, :kind, presence: true
  validates :priority, inclusion: { in: PRIORITIES }
  validates :budget, numericality: { greater_than_or_equal_to: 0 }
  validates :kind, inclusion: { in: KINDS }

  default_value_for :budget, 0.0
  default_value_for :priority, PRIORITIES.first
  default_value_for :kind,  KINDS.first

end
