require 'spec_helper'

describe "tasks/index" do
  before(:each) do
    assign(:tasks, [
      stub_model(Task,
        :name => "Name",
        :programmer => "Programmer",
        :project => "Project",
        :priority => "Priority",
        :notes => "MyText",
        :budget => "9.99",
        :status => "Status"
      ),
      stub_model(Task,
        :name => "Name",
        :programmer => "Programmer",
        :project => "Project",
        :priority => "Priority",
        :notes => "MyText",
        :budget => "9.99",
        :status => "Status"
      )
    ])
  end

  it "renders a list of tasks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Programmer".to_s, :count => 2
    assert_select "tr>td", :text => "Project".to_s, :count => 2
    assert_select "tr>td", :text => "Priority".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
