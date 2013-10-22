# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :project do
    sequence(:name) { |n| "Project ##{n}" }
    description     "some project description"

    trait :with_tasks do
      after(:create) do
        FactoryGirl.create_list(:task, (1..5).to_a.sample, project: project)
      end
    end
  end

  factory :task do
    project

    sequence(:name)       {|n| "Task ##{n}" }
    sequence(:programmer) {|n| "Programmer ##{n}" }
    notes                 "Some notes"
    status                "Not started"

    trait :started do
      status              "Started"
      started_on          { 3.days.ago }
    end

    trait :completed do
      status              "Completed"
      expired_on          { Time.now }
    end
  end
end
