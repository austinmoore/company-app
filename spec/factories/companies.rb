FactoryBot.define do
  factory :company do
    sequence(:name) { |i| "Company Name #{i}" }
  end
end
