class Project < ActiveRecord::Base

  belongs_to :user
  belongs_to :company
  has_many :tasks, dependent: :destroy

  validates :name, :user_id, :company_id, presence: true

end
