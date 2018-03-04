require 'rails_helper'

RSpec.describe Employee, type: :model do
  it {is_expected.to validate_presence_of(:first_name)}
  it {is_expected.to validate_presence_of(:last_name)}
  it {is_expected.to belong_to(:company)}
  it {is_expected.to have_db_index(:company_id)}

  context 'identifier' do
    it 'is initialized before creation' do
      employee = FactoryBot.build(:employee)
      expect(employee.identifier).to be_nil

      employee.save

      expect(employee.identifier).to be_present
    end

    it 'is initialized to XXXX-XXXX-XXXX' do
      employee = FactoryBot.create(:employee)
      expect(employee.identifier).to match(/\A[A-Z]{4}-[A-Z]{4}-[A-Z]{4}\z/)
    end

    it 'generates a unique token' do
      e1 = FactoryBot.create(:employee)
      e2 = FactoryBot.create(:employee)

      expect(e1.identifier).to_not eq(e2.identifier)
    end
  end
end
