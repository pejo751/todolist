
class Task < ActiveRecord::Base

  PRIORITY_DOMAIN = %w(Low Normal High)
  DEFAULT_PRIORITY = PRIORITY_DOMAIN.first
  STATUS_DOMAIN = ['Not started','Started','Completed']
  DEFAULT_STATUS = STATUS_DOMAIN.first
  KIND_DOMAIN = ['Back End', 'Front End', 'Testing', 'Estimation']
  DEFAULT_KIND = KIND_DOMAIN.first

  belongs_to :project

  validates :name, :programmer, :project_id, :priority,:kind,  presence: true
  validates :priority, inclusion: PRIORITY_DOMAIN
  validates :budget, numericality: {greater_than_or_equal_to: 0}
  validates :status, inclusion: STATUS_DOMAIN
  validates :kind, inclusion: KIND_DOMAIN
  validate :due_date_cannot_present_without_start_date
  validate :due_date_cannot_be_before_start_date

  def initialize(attributes=nil)
    attr_with_defaults = {
        budget: '0.0',
        priority: DEFAULT_PRIORITY,
        status: DEFAULT_STATUS,
        kind:  DEFAULT_KIND
      }.merge(attributes || {})
    super(attr_with_defaults)
  end

private

  def due_date_cannot_present_without_start_date
    if due_date.present? and not start_date.present?
      errors.add(:due_date, "can't present without start date")
    end
  end

  def due_date_cannot_be_before_start_date
    if start_date.present? && due_date.present? && due_date < start_date
      errors.add(:due_date, "can't be before the start date")
    end
  end

end
