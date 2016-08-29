require "rails_helper"

RSpec.feature "Products", :type => :feature do

  scenario "Login and do search" do

    visit login_path
    fill_in 'username', with: 'Ben Kenobi'
    click_button 'Submit'
    fill_in 'query', with: 'Apple iphone'
    click_button 'Search'
    expect(page).to have_text("Apple")

  end

end
