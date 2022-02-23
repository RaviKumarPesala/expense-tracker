module Api
  class EmployeeController < ApplicationController

    include EmployeeParamsValidator
    include CustomConstants::Employee, CustomConstants::StatusCodes

    before_action :role_admin_check, only: %i[ create index update destroy ]
    before_action :set_employee, only: %i[ show update destroy ]
    # before_action :validate_params_create, only: :create
    # before_action :validate_params_update, only: :update
    # before_action :validate_params_index, only: :index
    
    # POST /employee
    def create
      @employee = Employee.new(employee_params_create)
      if @employee.save
        render json: { message: CREATE_SUCCESS, status: OK, data: @employee }
      else
        render json: { message: CREATE_FAILED, status: UNPROCESSABLE_ENTITY, errors: @employee.errors }
      end
    end

    # GET /employee
    def index
      @employees = Employee.all
      render json: { status: OK, data: @employees } # EmployeeRepresenter.new(@employees).as_multiple_jsons
    end

    # GET /employee/:id
    def show
      render json: { status: OK, data: @employee } # EmployeeRepresenter.new(@employee).as_single_json
    end
    
    # PUT /employee/1
    def update
      if @employee.update(employee_params_update)
        render json: { message: UPDATE_SUCCESS, status: OK }
      else
        render json: { message: UPDATE_FAILED, status: UNPROCESSABLE_ENTITY, errors: @employee.errors }
      end
      rescue StandardError => e
        render json: { message: UPDATE_FAILED, status: UNPROCESSABLE_ENTITY, errors: e }
    end

    # DELETE /employee/1
    def destroy
      if @employee.destroy!
        render json: { message: DELETE_SUCCESS, status: OK }
      else
        render json: { message: DELETE_FAILED, status: UNPROCESSABLE_ENTITY }
      end
      rescue StandardError => e
        render json: { message: UPDATE_FAILED, status: UNPROCESSABLE_ENTITY, errors: e }
    end

  end
end
