
require 'spec_helper'

feature 'Multi-Tenant users sign up' do

  scenario 'with valid data' do
    visit new_user_registration_path
    within("#new_user") do
      fill_in "Company Name", with: "Stark Inc"
      fill_in "full name", with: "Tony Stark"
      fill_in "email", with: "me@starkinc.com"
      fill_in "password", with: "123123123"
      fill_in "password confirmation", with: "123123123"
    end
    click_on "Sign up"
    # Then a company called "Stark Inc" should exist
    expect(Company.find_by_name("Stark Inc")).to be_exist
    # and an user account should be created for "me@starkinc.com"
    # and this company's users should include "Tony Stark" user
    # and the user should be redirected to root_path
  end

  scenario 'with invalid data' do
    visit new_user_registration_path
    click_on "Sign up"
    # Then no company should have been created
    # and no user should have been created
    # and page should have content "Company name can't be blank"
    # and page should have content "Full name can't be blank"
    # and page should have content "email can't be blank"
    # and page should have content "password can't be blank"
  end
end
