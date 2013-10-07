require 'spec_helper'

describe "tasks/show" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :name => "Name",
      :programmer => "Programmer",
      :project => "Project",
      :priority => "Priority",
      :notes => "MyText",
      :budget => "9.99",
      :progress => 1,
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Programmer/)
    rendered.should match(/Project/)
    rendered.should match(/Priority/)
    rendered.should match(/MyText/)
    rendered.should match(/9.99/)
    rendered.should match(/1/)
    rendered.should match(/Status/)
  end
end
