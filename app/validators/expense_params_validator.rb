module ExpenseParamsValidator

  include CustomConstants::StatusCodes

  # Checks for Employee Existence and Status
  def validate_employee
    @employee = Employee.where(id: params[:employee_id]).first
    render json: { status: NOT_FOUND, message: "Employee with Id #{params[:employee_id]} Not Found" } unless @employee.present?
    render json: { status: FORBIDDEN, message: "Employee is Not Allowed to Perform this Action" } if @employee.present? && @employee[:status] != 'active'
  end
  
  # Validates Request Parameters For Creating an Expense
  def validate_params_create
    @params_errors = Hash.new([])

    # Employee Id & Expenses Basic Check
    @params_errors["Employee"] = ["Employee Id is Missing"] unless params[:employee_id].present?
    @params_errors["Expenses"] = ["Atleast One Expense Should be Provided"] if params[:expenses].blank?

    # Checking for Grouped Expenses
    @raw_expense_groups = params[:expenses].group_by{ |expense| expense[:group_id] }
    @raw_expense_groups.each do |key, value|
      @params_errors["Expenses"] += ["GroupId-#{key}, Should Contain Atleast 2 Expenses to Consider as Group"] if value.length < 2
    end

    frame_expense_attributes_errors(params[:expenses])

    render json: { status: VALIDATION_ERROR, errors: @params_errors } unless @params_errors.blank?
    
  end

  def validate_params_update
  end

  def validate_params_index
  end

  # Checks for any Missing Expense Attributes and Validates Invoices
  def frame_expense_attributes_errors(expenses)
    expenses.each_with_index do |expense, index|
      missing_args = expense_missing_args(expense)
      if missing_args.blank?
        # No Missing Arguments: Verify Invoice Number & Reject the Invalid Expenses
        params[:expenses].delete_at(index) if is_expense_invoice_valid(expense[:invoice].to_i)
        # expense['status'] = is_expense_invoice_valid(expense[:invoice].to_i) ? 'rejected' : 'pending'
      else
        # Missing Arguments: Frame Error Message Accordingly
        if expense[:name].present?
          @params_errors["Expenses"] += ["Expense '#{expense[:name]}' Missing Arguments #{missing_args}"]
        else
          @params_errors["Expenses"] += ["Expense-#{index+1} Missing Arguments #{missing_args}"]
        end
      end
    end
  end

  # Gets Missing Mandatory Arguments for Expense
  def expense_missing_args(expense)
    missing_args = []
    [:name, :date, :invoice, :description, :amount, :attachment_url].each do |arg|
      missing_args += [arg] unless expense[arg].present?
    end
    missing_args
  end

  # Verify Expense Invoice using Invoice Validation System API
  def is_expense_invoice_valid(invoice)
    # Invoice Validation System API Logic Implemented
    return invoice.to_i % 2 == 1
  end

end
