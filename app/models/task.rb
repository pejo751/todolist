
class Task < ActiveRecord::Base

  PRIORITY_DOMAIN = %w(Low Normal High)
  DEFAULT_PRIORITY = PRIORITY_DOMAIN.first
  STATUS_DOMAIN = ['Not started','In progress','Complete']
  DEFAULT_STATUS = STATUS_DOMAIN.first

  validates :name, :programmer, :priority, :progress, presence: true
  validates :priority, inclusion: PRIORITY_DOMAIN
  validates :budget, numericality: {greater_than_or_equal_to: 0}
  validates :progress,
    numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}
  validates :status, inclusion: STATUS_DOMAIN
  validate :due_date_cannot_present_without_start_date
  validate :due_date_cannot_be_before_start_date
  before_save :set_status

  def initialize(attributes=nil)
    attr_with_defaults = {
        progress: 0,
        priority: DEFAULT_PRIORITY,
        status: DEFAULT_STATUS
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

  def set_status
    self.status = case
      when progress == 100
        STATUS_DOMAIN[2]
      when progress > 0
        STATUS_DOMAIN[1]
      else
        status
    end
  end

end
