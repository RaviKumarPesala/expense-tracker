module Api
  class ExpenseCommentController < ApplicationController

    include ExpenseCommentParamsValidator
    include CustomConstants::ExpenseComment, CustomConstants::StatusCodes

    before_action :set_employee_expense, only: %i[ create ]
    after_action :notify_employee_expense_comment, only: %i[ create ]

    before_action :set_expenses, only: %i[ index ]

    # POST /employee/1/expense/1/expense_comment
    def create
      @expense_comment = ExpenseComment.new(expense_create_params)
      if @expense_comment.save
        render json: { message: CREATE_SUCCESS, status: OK, data: @expense_comment }
      else
        render json: { message: CREATE_FAILED, status: UNPROCESSABLE_ENTITY, errors: @expense_comment.errors }
      end
    end

    def index
      render json: { data: @expense_comments }
    end

  end
end
