require 'spec_helper'

describe Project do

  before :each do
    FactoryGirl.create(:project)
  end

  describe 'attributes' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:user_id).of_type(:integer) }
  end

  context 'associations' do
    it { should have_many(:tasks).dependent(:destroy) }
    it { should belong_to(:user) }
    it { should belong_to(:company) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:company_id) }
  end

  context 'factory' do
    it "creates a valid project" do
      expect{ FactoryGirl.create(:project) }.to change{ Project.count }.by(1)
    end
  end
end
