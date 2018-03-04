require 'rails_helper'

RSpec.describe Company, type: :model do
  it {is_expected.to validate_presence_of(:name)}
  it {is_expected.to have_db_index(:name).unique(true)}
  it {is_expected.to have_many(:employees).dependent(:destroy)}

  context 'with an existing company' do
    subject {FactoryBot.create(:company)}
    it {is_expected.to validate_uniqueness_of(:name)}
  end

  # The following block is almost identical between the company and the
  # employee since they both use the Tokenizable mixin. Its possible to extract
  # similar tests into an rspec shared examples
  # (https://relishapp.com/rspec/rspec-core/docs/example-groups/shared-examples).
  # In my experience though it just makes the specs harder to read and harder
  # to debug when something does go wrong. This is a case where I favor code
  # readability over "dryness". If I were to create a gem out of the two token
  # files in lib, I might create a custom rspec matcher so I could write
  # something like the following in my specs:
  #   it 'is initialized to XXXX:XXXX' do
  #     ...
  #     expect(company.identity).to be_a_token(delimiter: ':', block_count: 2)
  #   end
  # That would be overkill in this case though.
  #
  # You'll also notice that I don't have a test case specifically for the
  # Tokenizer mixin. Again, if I implemented it as a gem, I would write an
  # extra test case for it. Normally, I just make sure the classes that include
  # a mixin also test the mixin's functionality (at least part of it). That way
  # I can also switch to a different implementation and the tests should still
  # run.
  context 'identity' do
    it 'is initialized before creation' do
      company = FactoryBot.build(:company)
      expect(company.identity).to be_nil

      company.save

      expect(company.identity).to be_present
    end

    it 'is initialized to XXXX:XXXX' do
      company = FactoryBot.create(:company)
      expect(company.identity).to match(/\A[A-Z]{4}:[A-Z]{4}\z/)
    end

    it 'generates a unique token' do
      c1 = FactoryBot.create(:company)
      c2 = FactoryBot.create(:company)

      expect(c1.identity).to_not eq(c2.identity)
    end
  end
end
