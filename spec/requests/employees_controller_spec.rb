require 'rails_helper'

RSpec.describe EmployeesController, type: :request do
  describe 'DELETE #destroy' do
    it 'deletes the employee' do
      employee = FactoryBot.create(:employee)
      expect do
        expect do
          delete company_employee_path(employee.company, employee)
        end.to_not change(Company, :count)
      end.to change(Employee, :count).from(1).to(0)

      expect(Employee.where(id: employee.id)).to_not be_exist
    end

    it 'responds correctly' do
      employee = FactoryBot.create(:employee)

      delete company_employee_path(employee.company, employee)

      expect(response).to redirect_to(company_employees_path(employee.company))
    end
  end
end
