# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "MyString"
    description "MyText"
    # after :build do |p|
    #   p.tasks << FactoryGirl.build(:task)
    # end
  end
end
