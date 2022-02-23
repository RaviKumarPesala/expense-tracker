class Expense < ApplicationRecord

  include ModelConstants

  enum status: Expense::STATUS

  validates :name, presence: true
  validates :invoice, presence: true
  validates :amount, presence: true
  validates :date, presence: true
  validates :description, presence: true
  validates :attachment_url, presence: true

  belongs_to :employee, class_name: Employee::CLASS_NAME

  has_many :expense_comments, class_name: ExpenseComment::CLASS_NAME

  before_create :set_defaults

  def set_defaults
    self.status = Expense::STATUS[:pending]
    self.group_name ||= self.name
  end

end
