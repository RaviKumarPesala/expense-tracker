module Api
  class ExpenseController < ApplicationController

    include ExpenseParamsValidator
    include CustomConstants::Expense, CustomConstants::StatusCodes
    include ExpenseHelper

    before_action :set_expense, only: %i[ show update destroy ]
    before_action :set_expenses, only: %i[ index ]
    before_action :validate_employee, :validate_params_create, :format_raw_expenses_data, only: :create
    
    before_action :update_expense_status, only: %i[ update ]
    after_action :notify_employee_expense_status, only: %i[ update ]

    # POST /employee/1/expense
    def create
      # render json: @bulk_storing_expenses
      @expenses = Expense.insert_all(@bulk_storing_expenses)
      render json: { message: CREATE_SUCCESS, status: OK }
      rescue StandardError => e
        render json: { message: CREATE_FAILED, status: UNPROCESSABLE_ENTITY, errors: e }
    end

    # GET /employee/1/expense
    def index
      render json: { status: OK, data: ExpenseRepresenter.new(@expenses).as_multiple_jsons }
    end

    # GET /employee/1/expense/1
    def show
      render json: { status: OK, data: { expense: ExpenseRepresenter.new(@expense).as_single_json, comments: @expense_comments } }
    end

    # PUT /employee/1/expense/1
    def update
      if @expense.save
        render json: { message: UPDATE_SUCCESS, status: OK, data: @expense }
      else
        render json: { message: UPDATE_FAILED, status: UNPROCESSABLE_ENTITY, errors: @expense.errors }
      end
      rescue StandardError => e
        render json: { message: UPDATE_FAILED, status: UNPROCESSABLE_ENTITY, errors: e }
    end

    # DELETE /employee/1/expense/1
    def destroy
      if @expense.destroy!
        render json: { message: DELETE_SUCCESS, status: OK }
      else
        render json: { message: DELETE_FAILED, status: UNPROCESSABLE_ENTITY }
      end
      rescue StandardError => e
        render json: { message: UPDATE_FAILED, status: UNPROCESSABLE_ENTITY, errors: e }
    end

  end
end
