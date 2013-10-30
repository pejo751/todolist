require 'spec_helper'

describe Task do

  before :each do
    FactoryGirl.create(:task)
  end

  describe 'attributes' do
    it { should have_db_column(:notes).of_type(:text) }
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:programmer).of_type(:string) }
    it { should have_db_column(:priority).of_type(:string) }
    it { should have_db_column(:state).of_type(:string) }
    it { should have_db_column(:kind).of_type(:string) }
    it { should have_db_column(:started_on).of_type(:date) }
    it { should have_db_column(:completed_on).of_type(:date) }
    it { should have_db_column(:project_id).of_type(:integer) }
    it { should have_db_column(:budget).of_type(:decimal) }
    it { should_not allow_value(-1).for(:budget) }
  end

  context 'associations' do
    it { should belong_to(:project) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:programmer) }
    it { should validate_presence_of(:kind) }
    it { should ensure_inclusion_of(:kind).in_array(Task::KINDS) }
    it { should validate_presence_of(:priority) }
    it { should ensure_inclusion_of(:priority).in_array(Task::PRIORITIES) }
    it { should validate_numericality_of(
      :budget).is_greater_than_or_equal_to(0.0)
    }
  end
end
