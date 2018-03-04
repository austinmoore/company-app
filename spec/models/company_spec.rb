require 'rails_helper'

RSpec.describe Company, type: :model do
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to have_db_index(:name).unique(true)}
  it {is_expected.to have_many(:employees).dependent(:destroy)}

  context 'with an existing company' do
    subject {FactoryBot.create(:company)}
    it {is_expected.to validate_uniqueness_of(:name)}
  end
end
