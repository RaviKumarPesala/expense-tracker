class ExpenseStatusMailer < ApplicationMailer
  def notify_expense_status

    @message_type = params[:content_type]
    @sender = params[:sender]
    @recipient = params[:recipient]

    @employee_name = @recipient[:name]

    mail_subject = "Reimbursements Notification"
    if @message_type === "status"
      mail_subject = "Reimbursement: Expenses Status"
      @expense_submitted_on = params[:expenses][0][:date]
      @finance_team_contact_email = @sender[:email]
      @expenses = params[:expenses]
    else
      mail_subject = "Reimbursement: Expense Notification"
      @commenter_name = @sender[:name] || ""
      @comment_message = params[:comment_message] || ""
    end

    mail(to: @recipient[:email], subject: mail_subject)
    # cc: ["pesala10pesala@gmail.com", "pesala11pesala@gmail.com"], bcc: "pesala12pesala@gmail.com"
  end
end
