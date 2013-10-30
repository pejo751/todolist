require 'spec_helper'

describe User do
  before :each do
    FactoryGirl.create(:user)
  end

  describe "attributes" do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:current_sign_in_ip).of_type(:string) }
    it { should have_db_column(:last_sign_in_ip).of_type(:string) }
    it { should have_db_column(:full_name).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }
    it { should have_db_column(:current_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:last_sign_in_at).of_type(:datetime) }
    it { should have_db_column(:sign_in_count).of_type(:integer) }
  end

  context 'associations' do
    it { should belong_to(:company) }
  end

  context "validations" do
    it { should validate_presence_of(:full_name) }
  end
end
