require 'spec_helper'

feature 'registering new project' do

  scenario 'with correct values' do
    visit '/projects/new'
    within("#new_project") do
      fill_in 'Name', with: 'jorge'
      fill_in 'Description', with: 'bla bla bla'
    end
    click_button 'Create Project'
    # save_and_open_page
    expect(page).to have_content 'Project was successfully created.'
  end
end
