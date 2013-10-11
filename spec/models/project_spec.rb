require 'spec_helper'

describe Project do

  before :each do
    @project = FactoryGirl.create(:project)
  end

  describe "validations" do

    it 'requires #name' do
      @project.name = nil
      expect(@project.valid?).to be_false
    end

    it 'should have defined "has_many :tasks" association' do
        expect(Project.reflect_on_association(:tasks).macro).to eq(:has_many)
    end

    it 'should accept many tasks' do
        expect(@project.tasks.count).to eq(5)
    end

    it 'when the project is deleted, the associated tasks are eliminated' do
        @project.destroy

        expect(Project.count).to eql(0)
        expect(Task.count).to eql(0)
    end

  end

end
