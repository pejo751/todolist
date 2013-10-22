require 'spec_helper'

feature 'first scenario' do
  include Capybara::DSL

  scenario 'Go to home' do
    visit '/'
    page.current_url.should eq('http://localhost:3000/')
    page.should have_content('Welcome')
  end
end
