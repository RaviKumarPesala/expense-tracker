class Employee < ApplicationRecord

  include ModelConstants

  enum status: Employee::STATUS
  enum role: Employee::ROLES

  validates :name, presence: true, length: { in: 3..20 }
  validates :gender, presence: true, inclusion: { in: Employee::GENDER_VALID_CODES, message: Employee::GENDER_VALIDATION_MSG }
  validates :email, presence: true, uniqueness: true
  validates :mobile_number, presence: true, uniqueness: true
  validates :address, presence: true, length: { in: 20..200 }
  validates :pincode, presence: true

  has_many :expenses, class_name: Expense::CLASS_NAME

  before_create :set_defaults

  def set_defaults
    self.status = Employee::STATUS[:active]
    self.department_id = ''
    self.role = Employee::ROLES[:employee]
  end

end
