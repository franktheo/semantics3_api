require "rails_helper"

RSpec.feature "Products", :type => :feature do

  scenario "Admin login, prefetch and cache", :js => true do
    visit login_path
    fill_in 'username', with: 'Ben Kenobi'
    click_button 'Log In'
    fill_in 'query1', with: 'Apple iphone'
    fill_in 'query2', with: 'Samsung Galaxy 7S'
    fill_in 'query3', with: 'Sharp TV'
    fill_in 'query4', with: 'Sony TV'
    fill_in 'query5', with: 'Toshiba TV'
    click_button 'Prefetch & cache in the backround'
    click_link 'Log out'
  end

  scenario "Admin login, clear cache", :js => true do
    visit login_path
    fill_in 'username', with: 'Ben Kenobi'
    click_button 'Log In'
    click_link 'Clear Cached Data'
    click_link 'Log out'
  end

  scenario "User login and do search", :js => true do
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

  scenario "Non-registered user login", :js => true do
    visit login_path
    fill_in 'username', with: 'John Doe'
    click_button 'Log In'
    expect(page).to have_text("Login")
  end

end
