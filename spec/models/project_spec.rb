require 'spec_helper'

describe Project do

  before :each do
    @project = FactoryGirl.build(:project)
  end

  describe "validations" do

    it 'requires #name' do
      @project.name = nil
      expect(@project.valid?).to be_false
    end

    it "should have many tasks" do
        expect(Project.reflect_on_association(:tasks).macro).to eq(:has_many)
    end

  end

end
