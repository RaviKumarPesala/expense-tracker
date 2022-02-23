module ExpenseHelper

  include CustomConstants::StatusCodes

  # Fetch & Sets Expense & Employee Records using Id and Employee Id if exist
  def set_expense
    @employee = Employee.where(params[:employee_id]).first if params[:employee_id].present?
    @expense = params[:employee_id].present? ? Expense.where(id: params[:id], employee_id: params[:employee_id]).first : Expense.find(params[:id])
    @expense_comments = ExpenseComment.where(expense_id: params[:id]).order("created_at DESC")
    render json: { status: NOT_FOUND, message: "Expense with id #{params[:id]} not found" } unless @expense.present?
  end

  # Fetch & Sets Expenses Records & Employee if Employee Id if exist
  def set_expenses
    @employee = Employee.find(params[:employee_id]) if params[:employee_id].present?
    @expenses = params[:employee_id].present? ? Expense.where(employee_id: params[:employee_id]) : Expense.all
    rescue ActiveRecord::RecordNotFound => e
      render json: { status: NOT_FOUND, message: "Expenses with employee id #{params[:employee_id]} not found" }
  end

  # Define Set of Valid Attributes for Updating Employee
  def expense_params_update
    params.require(:expense).permit(:status)
  end

  # Formats the Input Request for Creating Expenses
  def format_raw_expenses_data
    current_max_group = Expense.where(employee_id: params[:employee_id], expense_type: 'G').maximum("group_id") || 0
    @bulk_storing_expenses = format_expenses_raw_input(current_max_group)
  end

  def format_expenses_raw_input(current_max_group = 0)
    formated_expenses = []
    @raw_expense_groups.each do |key, value|
      value.each do |expense|
        expense['employee_id'] = params[:employee_id]
        expense['group_id'] = current_max_group + 1 if expense[:expense_type] == 'G'
        formated_expenses << expense
      end
      current_max_group += 1
    end
    formated_expenses
  end

  # Updates Expense Status
  def update_expense_status
    @expense[:status] = params[:status]
  end

  # Email Notification for Employee when Expense Status Updated
  def notify_employee_expense_status
    employee = Employee.where(id: @expense[:employee_id]).first
    if employee.present? && @employee.present?
      ExpenseStatusMailer
        .with(content_type: "status", sender: @employee, recipient: employee, expenses: [@expense])
        .notify_expense_status
        .deliver
    end
  end
  
end
