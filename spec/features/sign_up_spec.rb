
require 'spec_helper'

feature 'Multi-Tenant users sign up' do

  background do
    visit '/signup'
  end

  scenario 'with valid data' do
    fill_in "user[company_attributes][name]", with: "Stark Inc"
    fill_in "user[full_name]",                with: "Tony Stark"
    fill_in "user[email]",                    with: "me@starkinc.com"
    fill_in "user[password]",                 with: "123123123"
    fill_in "user[password_confirmation]",    with: "123123123"
    click_on "Sign up"

    expect(Company.where(name: "Stark Inc")).to exist
    expect(User.where(email: "me@starkinc.com")).to exist

    user    = User.last
    company = user.company
    expect(company.users).to include(user)
    expect(current_path).to eq(root_path)
  end

  scenario 'with invalid data' do
    click_on "Sign up"

    expect(Company.count).to eq(0)
    expect(User.count).to eq(0)

    expect(page).to have_content "Company name can't be blank"
    expect(page).to have_content "Full name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end
end
