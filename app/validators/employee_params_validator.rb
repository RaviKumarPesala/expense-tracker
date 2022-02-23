module EmployeeParamsValidator

  include CustomConstants::StatusCodes

  # Fetch & Sets Employee Record using Id
  def set_employee
    @employee = Employee.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { status: NOT_FOUND, message: "Employee with Id #{params[:id]} Not Found", errors: e.message }
  end

  # Define Set of Valid Attributes for Creating Employee
  def employee_params_create
    params.require(:employee)
      .permit(:name, :date_of_birth, :gender, :email, :mobile_number, :phone, :address, :pincode)
  end

  # Define Set of Valid Attributes for Updating Employee
  def employee_params_update
    params.require(:employee)
      .permit(:status, :department_id, :role)
  end
  
  def validate_params_create
  end

  def validate_params_update
  end

  def validate_params_index
  end

  def role_admin_check
    current_user_role = headers['role'] || 'employee'
    render json: { status: UNAUTHORIZED, message: "User Cannot Perform This Action." } unless current_user_role == 'admin'
  end

end
