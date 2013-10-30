# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :company do
    sequence(:name) { |n| "Company ##{n}" }

    trait :with_users do
      after(:create) do
        FactoryGirl.create_list(:user, (1..5).to_a.sample, company: company)
      end
    end
  end
end
