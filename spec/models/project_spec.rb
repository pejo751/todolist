require 'spec_helper'

describe Project do

  before :each do
    FactoryGirl.create(:project)
  end

  describe 'attributes' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
  end

  context 'associations' do
    it { should have_many(:tasks).dependent(:destroy) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end
end
