FactoryBot.define do
  factory :company do
    sequence(:name) { |i| "Company Name #{i}" }

    trait :with_employees do
      transient do
        number_of_employees 1
      end

      after(:create) do |company, evaluator|
        create_list(:employee, evaluator.number_of_employees, company: company)
      end
    end
  end
end
