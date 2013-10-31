# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :user do
    company

    sequence(:full_name)  { |n| "User ##{n}" }
    sequence(:email)      { |n| "user-#{n}@tasks.test" }
    password              "12345678"
    password_confirmation "12345678"
  end
end
