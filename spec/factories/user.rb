# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :user do
    company

    sequence(:full_name) { |n| "User ##{n}" }
    email                "1@1.com"
    password             "12345678"

  end
end
