require "rails_helper"

RSpec.feature "Products", :type => :feature do

  scenario "Do search", :js => true do

    visit root_path
    fill_in 'query', with: 'Apple iphone'
    click_button 'Search'
    expect(page).to have_text("Apple")

  end

end
