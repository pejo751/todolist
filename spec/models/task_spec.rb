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

    context "with valid #priority" do
      before :each do
        @task.priority = Task::PRIORITY_DOMAIN.first
      end

      it 'returns a valid record' do
        expect(@task.valid?).to be_true
      end

      it 'does not raises an error for #priority' do
        @task.valid?
        expect(@task.errors).to_not have_at_least(1).errors_on(:priority)
      end
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

    context 'with #start_date' do
      before :each do
        @task.start_date = nil
      end

      it 'requires #start_date' do
        expect(@task.valid?).to be_false
      end

      it 'raises an error when empty' do
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:start_date)
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

    context 'with #progress' do
      it 'requires #progress' do
        @task.progress = nil
        expect(@task.valid?).to be_false
      end

      it 'raises an error when empty' do
        @task.progress = nil
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:progress)
      end

      it 'raises an error when is not numeric' do
        @task.progress = 'uno'
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:progress)
      end

      it 'raises an error when is greater than one hundred' do
        @task.progress = 101
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:progress)
      end
    end

    context 'with #status' do
      it 'requires #status' do
        @task.status = nil
        expect(@task.valid?).to be_false
      end

      it 'raises an error when empty' do
        @task.status = nil
        @task.valid?
        expect(@task.errors).to have_at_least(1).errors_on(:status)
      end

      context 'when #progress equal zero' do
        it "task status should be not started" do
          @task.progress = 0
          @task.save
          expect(@task.status).to eq(Task::STATUS_DOMAIN.first)
        end
      end

      context 'when #progress greater than 0 and less than 100' do
        it "task status should be in progress" do
          @task.progress = 50
          @task.save
          expect(@task.status).to eq(Task::STATUS_DOMAIN[1])
        end
      end

      context 'when #progress equal 100' do
        it "task status should be completed" do
          @task.progress = 100
          @task.save
          expect(@task.status).to eq(Task::STATUS_DOMAIN[2])
        end
      end

    end

  end

  describe 'behaviours' do

    it "#progress is setted to 0" do
      expect(@task.progress).to eq(0)
    end

    it "#status is setted with the default value" do
      expect(@task.status).to eq(Task::DEFAULT_STATUS)
    end

  end

end
