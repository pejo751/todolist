require 'spec_helper'

describe Company do
  before :each do
    FactoryGirl.create(:company)
  end

  describe 'attributes' do
    it { should have_db_column(:name).of_type(:string) }
  end

  context 'associations' do
    it { should have_many(:users) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
