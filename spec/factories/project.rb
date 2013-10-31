# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :project do
    user
    company

    sequence(:name) { |n| "Project ##{n}" }
    description     "some project description"

    trait :with_tasks do
      after(:create) do
        FactoryGirl.create_list(:task, (1..5).to_a.sample, project: project)
      end
    end
  end
end
