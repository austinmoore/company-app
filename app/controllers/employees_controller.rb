class EmployeesController < ApplicationController
  before_action :set_employees
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  # GET companies/1/employees
  def index
    @employees = @company.employees
  end

  # GET companies/1/employees/1
  def show
  end

  # GET companies/1/employees/new
  def new
    @employee = @company.employees.build
  end

  # GET companies/1/employees/1/edit
  def edit
  end

  # POST companies/1/employees
  def create
    @employee = @company.employees.build(employee_params)

    if @employee.save
      redirect_to([@employee.company, @employee], notice: 'Employee was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT companies/1/employees/1
  def update
    if @employee.update_attributes(employee_params)
      redirect_to([@employee.company, @employee], notice: 'Employee was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE companies/1/employees/1
  def destroy
    @employee.destroy

    redirect_to company_employees_url(@company)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employees
    @company = Company.find(params[:company_id])
  end

  def set_employee
    @employee = @company.employees.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def employee_params
    params.require(:employee).permit(:first_name, :last_name)
  end
end
