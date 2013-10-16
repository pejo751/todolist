class Task < ActiveRecord::Base

  PRIORITY_DOMAIN = %w(Low Normal High)
  DEFAULT_PRIORITY = PRIORITY_DOMAIN.first
  STATUS_DOMAIN = ['Not started','Started','Completed']
  DEFAULT_STATUS = STATUS_DOMAIN.first
  KIND_DOMAIN = ['Back End', 'Front End', 'Testing', 'Estimation']
  DEFAULT_KIND = KIND_DOMAIN.first

  belongs_to :project
  delegate :name, to: :project, prefix: true

  validates :name, :programmer, :project_id, :priority,:kind,  presence: true
  validates :priority, inclusion: PRIORITY_DOMAIN
  validates :budget, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: STATUS_DOMAIN
  validates :kind, inclusion: KIND_DOMAIN
  validate :due_date_cannot_present_without_start_date
  validate :due_date_cannot_be_before_start_date
  validate :status_cannot_have_default_value_when_present_start_date
  validate :status_is_not_default_value_and_not_present_start_date

  def initialize(attributes = {})
    attr_with_defaults = {
      budget: '0.0',
      priority: DEFAULT_PRIORITY,
      status: DEFAULT_STATUS,
      kind:  DEFAULT_KIND
    }.merge(attributes)
    super(attr_with_defaults)
  end

  def to_s
    "\"#{name}\""
  end

  private

  def due_date_cannot_present_without_start_date
    if due_date.present? && !start_date.present?
      errors.add(:due_date, "can't present without start date")
    end
  end

  def due_date_cannot_be_before_start_date
    if start_date.present? && due_date.present? && due_date < start_date
      errors.add(:due_date, "can't be before the start date")
    end
  end

  def status_cannot_have_default_value_when_present_start_date
    if status == DEFAULT_STATUS && start_date.present?
      errors.add(:status, "can't have \"#{DEFAULT_STATUS}\" when present start date")
    end
  end

  def status_is_not_default_value_and_not_present_start_date
    if status != DEFAULT_STATUS && !start_date.present?
      errors.add(:status, "should be \"#{DEFAULT_STATUS}\"")
    end
  end
end
