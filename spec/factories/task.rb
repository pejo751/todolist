# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do

  factory :task do
    project

    sequence(:name)       {|n| "Task ##{n}" }
    sequence(:programmer) {|n| "Programmer ##{n}" }
    notes                 "Some notes"
    state                 "not_started"

    trait :started do
      state               "started"
      started_on          { 3.days.ago }
    end

    trait :completed do
      state               "completed"
      completed_on        { Time.now }
    end

    trait :not_started do
      state               "not_started"
    end
  end
end
