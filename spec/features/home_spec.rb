require 'spec_helper'
include Capybara::DSL

feature 'first scenario' do

  scenario 'Go to home' do
    visit '/'
    page.current_url.should eq('http://localhost:3000/')
    page.should have_content('Listing tasks')
  end
end
