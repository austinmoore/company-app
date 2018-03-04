require 'rails_helper'

RSpec.describe Employee, type: :model do
  it {is_expected.to validate_presence_of(:first_name)}
  it {is_expected.to validate_presence_of(:last_name)}
  it {is_expected.to belong_to(:company)}
  it {is_expected.to have_db_index(:company_id)}
end
