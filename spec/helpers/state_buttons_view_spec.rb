require 'spec_helper'

describe StateButtonsView do
  context "with a started task" do
    before(:each) do
      started_task = FactoryGirl.create(:task, :started)
      Nokogiri::HTML(StateButtonsView.new(started_task).render).xpath("//a").each do |node|
        @buttons ||= []
        @buttons << node.text
      end
    end

    it 'should return links html tags "Not_started" and "Completed"' do
      @buttons.should include("Not_started", "Completed")
    end

    it 'should not return link html tag "Not_started"' do
      @buttons.should_not include("Started")
    end
  end

  context "with a completed task" do
    before(:each) do
      completed_task = FactoryGirl.create(:task, :completed)
    end
  end

  context "with a not started task" do
    before(:each) do
      not_started_task = FactoryGirl.create(:task, :not_started)
    end
  end
end
