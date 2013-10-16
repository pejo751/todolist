require 'spec_helper'

describe Task do

  before :each do
    @task = FactoryGirl.build(:task)
  end

  describe "validations" do
    it 'requires #name' do
      @task.name = nil
      expect(@task.valid?).to be_false
    end

    it 'raises an error when #name is empty' do
      @task.name = nil
      @task.valid?
      expect(@task.errors).to have_at_least(1).errors_on(:name)
    end

    it 'requires #programmer' do
      @task.programmer = nil
      expect(@task.valid?).to be_false
    end

    it 'raise an error when #programmer is empty' do
      @task.programmer = nil
      @task.valid?
      expect(@task.errors).to have_at_least(1).errors_on(:programmer)
    end

    it 'requires #kind' do
      @task.kind = nil
      expect(@task.valid?).to be_false
    end

    it 'raise an error when #kind is empty' do
      @task.kind = nil
      @task.valid?
      expect(@task.errors).to have_at_least(1).errors_on(:programmer)
    end

    context "with invalid #priority" do
      before :each do
        @task.priority = 99
      end

      it 'returns a invalid record' do
        expect(@task.valid?).to be_false
      end

      it 'raises an error for #priority' do
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:priority)
      end
    end

    context 'when #budget is not empty' do
      it 'raises an error when #budget is not numeric' do
        @task.budget = 'uno'
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:budget)
      end

      it 'raises an error when #budget is less than zero' do
        @task.budget = -1
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:budget)
      end
    end

    context 'when #due_date is not empty' do
      before :each do
        @task.due_date = Date.today
      end

      it 'raises an error when #start_date is empty' do
        @task.start_date = nil
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:due_date)
      end

      it 'raises an error when #due_date is before #start_date' do
        @task.start_date = @task.due_date + 1
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:due_date)
      end
    end

    context 'with #status' do
      before :each do
        @task.start_date = Date.today
      end

      it 'requires #status' do
        @task.status = nil
        expect(@task.valid?).to be_false
      end

      it 'raises an error when empty' do
        @task.status = nil
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:status)
      end

      it 'raises an error when value is default and present #start_date' do
        @task.status = Task::DEFAULT_STATUS
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:status)
      end

      it 'raises an error when is not default value and not present #start_date' do
        @task.status = Task::STATUS_DOMAIN[1]
        @task.start_date = nil
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:status)
      end
    end

    it 'verify instance method #to_s' do
        expect(@task.to_s).to eq("\"#{@task.name}\"")
    end
  end

  describe 'behaviours' do

    it "#kind is setted with the default value" do
      expect(@task.kind).to eq(Task::DEFAULT_KIND)
    end

    it "#priority is setted with the default value" do
      expect(@task.priority).to eq(Task::DEFAULT_PRIORITY)
    end

    it "#budget is setted to 0.00" do
      expect(@task.budget.to_s).to eq('0.0')
    end

    it "#status is setted with the default value" do
      expect(@task.status).to eq(Task::DEFAULT_STATUS)
    end
  end
end
