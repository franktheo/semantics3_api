require "rails_helper"

RSpec.feature "Products", :type => :feature do

  scenario "Admin login, prefetch and cache" do
    visit login_path
    fill_in 'username', with: 'Ben Kenobi'
    click_button 'Log In'
    fill_in 'query', with: 'Apple iphone'
    click_button 'Prefetch & cache in the backround'
    #expect(page).to have_text("Apple")
    click_link 'Log out'
  end

  scenario "User login and do search" do
    visit login_path
    fill_in 'username', with: 'Tony Stark'
    click_button 'Log In'
    fill_in 'query', with: 'Apple iphone'
    click_button 'Search'
    expect(page).to have_text("Apple")
    click_link 'Search Again'
    fill_in 'query', with: 'Apple iphone'
    click_button 'Search'
    click_link 'Log out'
  end

  scenario "Non-registered user login" do
    visit login_path
    fill_in 'username', with: 'John Doe'
    click_button 'Log In'
    expect(page).to have_text("Login")
  end

end
