require 'spec_helper'

describe Stager do
  context 'with a started task' do
    before(:each) do
      @started_task = FactoryGirl.create(:task, :started)
      @stager       = Stager.new(@started_task)
    end

    describe '#not_start' do
      it 'sets state with "not_started"' do
        expect{@stager.not_start}.to change{
          @started_task.state}.to('not_started')
      end

      it 'resets started_on field' do
        expect{@stager.not_start}.to change{@started_task.started_on}.to(nil)
      end
    end

    describe '#complete' do
      it 'sets state with "completed"' do
        expect{@stager.complete}.to change{@started_task.state}.to('completed')
      end

      it 'does not reset started_on field' do
        expect{@stager.complete}.not_to change{
          @started_task.started_on}.to(nil)
      end

      it 'sets completed_on field with datestamp' do
        expect{@stager.complete}.to change{
          @started_task.completed_on}.to(Date.today)
      end
    end
  end

  context 'with a completed task' do
    before(:each) do
      @completed_task = FactoryGirl.create(:task, :completed)
      @stager = Stager.new(@completed_task)
    end

    describe '#not_start' do
      it 'sets state with "not_started"' do
        expect{@stager.not_start}.to change{
          @completed_task.state}.to('not_started')
      end

      it 'resets completed_on field' do
        expect{@stager.not_start}.to change{
          @completed_task.completed_on}.to(nil)
      end
    end

    describe '#start' do
      it 'sets state with "started"' do
        expect{@stager.start}.to change{@completed_task.state}.to('started')
      end

      it 'resets completed_on field' do
        expect{@stager.start}.to change{@completed_task.completed_on}.to(nil)
      end

      it 'sets started_on field with datestamp' do
        expect{@stager.start}.to change{
          @completed_task.started_on}.to(Date.today)
      end
    end
  end

  context 'with a not started task' do
    before(:each) do
      @not_started_task = FactoryGirl.create(:task, :not_started)
      @stager = Stager.new(@not_started_task)
    end

    describe '#start' do
      it 'sets state with "started"' do
        expect{@stager.start}.to change{@not_started_task.state}.to('started')
      end

      it 'sets started_on field with datestamp' do
        expect{@stager.start}.to change{
          @not_started_task.started_on}.to(Date.today)
      end
    end

    describe '#complete' do
      it 'sets state with "completed"' do
        expect{@stager.complete}.to change{
          @not_started_task.state}.to('completed')
      end

      it 'sets completed_on field with datestamp' do
        expect{@stager.complete}.to change{
          @not_started_task.completed_on}.to(Date.today)
      end
    end
  end
end
