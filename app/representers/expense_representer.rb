class ExpenseRepresenter

  def initialize(expenses, role = 'E')
    @expenses = expenses
  end

  def as_multiple_jsons
    @expenses.map do |expense|
      {
        id: expense.id,
        employee: expense.employee_id,
        name: expense.name,
        status: expense.status,
        invoice: expense.invoice,
        amount: expense.amount,
        date: expense.date,
        description: expense.description,
        groupId: expense.group_id,
        groupName: expense.group_name,
        attachementUrl: expense.attachment_url
      }
    end
  end

  def as_single_json
    {
      id: @expenses.id,
      employee: @expenses.employee_id,
      name: @expenses.name,
      status: @expenses.status,
      invoice: @expenses.invoice,
      amount: @expenses.amount,
      date: @expenses.date,
      description: @expenses.description,
      groupId: @expenses.group_id,
      groupName: @expenses.group_name,
      attachementUrl: @expenses.attachment_url
    }
  end

  private
  
  attr_reader :expenses

end