module CustomConstants

  module StatusCodes
    OK                           = 200
    BAD_REQUEST                  = 400
    VALIDATION_ERROR             = 400
    UNAUTHORIZED                 = 401
    FORBIDDEN                    = 403
    NOT_FOUND                    = 404
    NOT_ALLOWED                  = 405
    UNPROCESSABLE_ENTITY         = 422
    INTERNAL_SERVER_ERROR        = 500
  end

  module Employee
    CREATE_SUCCESS      = "Employee Created Successfully"
    CREATE_FAILED       = "Employee Creation Failed"
    UPDATE_SUCCESS      = "Employee Details Updated Successfully"
    UPDATE_FAILED       = "Employee Details Upadate Failed"
    DELETE_SUCCESS      = "Employee Deleted Successfully"
    DELETE_FAILED       = "Employee Deletion Failed"
    FETCH_FAILED        = "Employee Fetch Failed"
  end

  module Expense
    CREATE_SUCCESS      = "Expense Created Successfully"
    CREATE_FAILED       = "Expense Creation Failed"
    UPDATE_SUCCESS      = "Expense Details Updated Successfully"
    UPDATE_FAILED       = "Expense Details Upadate Failed"
    DELETE_SUCCESS      = "Expense Deleted Successfully"
    DELETE_FAILED       = "Expense Deletion Failed"
    FETCH_FAILED        = "Expense Fetch Failed"
  end

  module ExpenseComment
    CREATE_SUCCESS      = "Commented Added Successfully"
    CREATE_FAILED       = "Comment Adding Failed"
    FETCH_FAILED        = "Comments Fetch Failed"
  end

end