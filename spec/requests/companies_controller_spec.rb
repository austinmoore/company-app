require 'rails_helper'

RSpec.describe CompaniesController, type: :request do
  describe 'DELETE #destroy' do
    it 'deletes company and its employees' do
      company = FactoryBot.create(:company, :with_employees,
                                  number_of_employees: 3)
      expect do
        expect do
          delete company_path(company)
        end.to change(Company, :count).from(1).to(0)
      end.to change(Employee, :count).from(3).to(0)

      expect(Company.where(id: company.id)).to_not be_exist
    end

    it 'responds correctly' do
      company = FactoryBot.create(:company, :with_employees,
                                  number_of_employees: 3)

      delete company_path(company)

      expect(response).to redirect_to(companies_path)
    end
  end
end
