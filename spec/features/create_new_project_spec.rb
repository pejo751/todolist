require 'spec_helper'

feature 'create new project' do
  given(:user) { FactoryGirl.create(:user) }

  scenario 'with correct values' do
    login_with(user)
    visit '/projects/new'

    fill_in 'project[name]',        with: 'jorge'
    fill_in 'project[description]', with: 'bla bla bla'

    click_button 'Create Project'
    expect(page).to have_content 'Project was successfully created.'
  end

  scenario 'restricted access for visitors' do
    visit '/projects/new'
    expect(current_path).to eql(new_user_session_path)
  end
end
