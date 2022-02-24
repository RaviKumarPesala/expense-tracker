class ExpenseComment < ApplicationRecord

  include ModelConstants

  validates :sender, presence: true
  validates :reciever, presence: true
  validates :message, presence: true

  belongs_to :expense, class_name: Expense::CLASS_NAME

end
