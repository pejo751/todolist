require 'spec_helper'

feature 'Go to home' do

  scenario 'first scenario' do
    visit '/'
    page.current_url.should eq('http://localhost:3000/')
    page.should have_content('Listing tasks')
  end
end
