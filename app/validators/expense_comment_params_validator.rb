module ExpenseCommentParamsValidator
  
  include CustomConstants::StatusCodes

  def set_employee_expense
    @expense_commenter = Employee.where(id: params[:sender]).first
    render json: { status: NOT_FOUND, message: "Employee with Id #{params[:sender]} Not Found" } unless @expense_commenter.present?
    @expense = Expense.where(id: params[:expense_id]).first
    render json: { status: NOT_FOUND, message: "Expense with Id #{params[:expense_id]} Not Found" } unless @expense.present?
  end

  # Fetch & Sets Expense Comments using Expense Id
  def set_expenses
    @expense_comments = ExpenseComment.where(expense_id: params[:expense_id])
  end

  # Define Set of Valid Attributes for Creating Expense Comments
  def expense_create_params
    params.require(:expense_comment).permit(:expense_id, :message, :sender, :reciever)
  end

  # Email Notification for Employee when a Comment Added to Expense
  def notify_employee_expense_comment
    # expense_commenter = Employee.where(id: params[:employee_id]).first
    expense_owner = Employee.where(id: @expense[:employee_id]).first
    # render json: { params: params, expense: @expense, recipient: expense_owner, sender: expense_commenter }
    if @expense_commenter.present? && expense_owner.present? && (@expense[:employee_id] != @expense_commenter[:id])
      ExpenseStatusMailer
        .with(content_type: "comment", sender: @expense_commenter, recipient: expense_owner, comment_message: params[:message])
        .notify_expense_status
        .deliver
    end
  end

end