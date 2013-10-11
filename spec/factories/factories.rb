# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :task do
    name "MyString"
    programmer "MyString"
    # priority "Low"
    notes "MyText"
    # budget "9.99"
    # start_date "2013-10-03"
    # due_date "2013-10-03"
    # status "Not started"
    # project {|project| project.association(:project, :name => 'Writely') }
    project
    # project FactoryGirl.build(:project)
    # project {|project| project.association(:project, FactoryGirl.build(:project)) }
  end

  factory :project do
    name "MyString"
    description "MyText"
  end
end
