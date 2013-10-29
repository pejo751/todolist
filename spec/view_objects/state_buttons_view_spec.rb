require 'spec_helper'

describe StateButtonsView do
  context "with a started task" do
    before(:each) do
      @started_task = FactoryGirl.create(:task, :started)
      @output = StateButtonsView.new(@started_task).render
    end

    it "includes link to not_start feature" do
      url = stage_change_path(
        @started_task.project_id, @started_task.id, :not_started)
      expect(@output).to match(/href="#{url}"/)
    end

    it "includes link to complete feature" do
      url = stage_change_path(
        @started_task.project_id, @started_task.id, :completed)
      expect(@output).to match(/href="#{url}"/)
    end
  end

  context "with a completed task" do
    before(:each) do
      @completed_task = FactoryGirl.create(:task, :completed)
      @output = StateButtonsView.new(@completed_task).render
    end

    it "includes link to start feature" do
      url = stage_change_path(
        @completed_task.project_id, @completed_task.id, :started)
      expect(@output).to match(/href="#{url}"/)
    end

    it "includes link to not_start feature" do
      url = stage_change_path(
        @completed_task.project_id, @completed_task.id, :not_started)
      expect(@output).to match(/href="#{url}"/)
    end
  end

  context "with a not started task" do
    before(:each) do
      @not_started_task = FactoryGirl.create(:task, :not_started)
      @output = StateButtonsView.new(@not_started_task).render
    end

    it "includes link to complete feature" do
      url = stage_change_path(
        @not_started_task.project_id, @not_started_task.id, :completed)
      expect(@output).to match(/href="#{url}"/)
    end

    it "includes link to start feature" do
      url = stage_change_path(
        @not_started_task.project_id, @not_started_task.id, :started)
      expect(@output).to match(/href="#{url}"/)
    end
  end
end
