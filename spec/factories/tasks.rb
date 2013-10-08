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
    # progress 0
    # status "Not started"
    project {|project| project.association(:project, :name => 'Writely') }
  end
end
