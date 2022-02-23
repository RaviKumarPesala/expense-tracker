module ModelConstants

  module Employee
    STATUS = { active: 'Active', terminated: 'Terminated', separated: 'Separated' }
    ROLES = { employee: 'E', admin: 'A' }
    
    CLASS_NAME = "Employee"

    GENDER_VALID_CODES = ['M', 'F']
    GENDER_VALIDATION_MSG = "%{value} is not a valid gender"
  end
  
  module Expense
    STATUS = { pending: 'Pending', approved: 'Approved', rejected: 'Rejected' }

    CLASS_NAME = "Expense"
  end

  module ExpenseComment
    CLASS_NAME = "ExpenseComment"
  end

end