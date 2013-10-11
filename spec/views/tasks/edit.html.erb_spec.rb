require 'spec_helper'

describe "tasks/edit" do
  before(:each) do
    @task = assign(:task, stub_model(Task,
      :name => "MyString",
      :programmer => "MyString",
      :project => "MyString",
      :priority => "MyString",
      :notes => "MyText",
      :budget => "9.99",
      :status => "MyString"
    ))
  end

  it "renders the edit task form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", task_path(@task), "post" do
      assert_select "input#task_name[name=?]", "task[name]"
      assert_select "input#task_programmer[name=?]", "task[programmer]"
      assert_select "input#task_project_id[name=?]", "task[project_id]"
      assert_select "input#task_priority[name=?]", "task[priority]"
      assert_select "textarea#task_notes[name=?]", "task[notes]"
      assert_select "input#task_budget[name=?]", "task[budget]"
      assert_select "input#task_status[name=?]", "task[status]"
    end
  end
end
