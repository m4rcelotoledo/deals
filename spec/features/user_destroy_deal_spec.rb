# frozen_string_literal: true

require 'rails_helper'

feature 'User destroy a deal' do
  scenario 'successfully' do
    user = create(:user)
    create(:deal, user: user)
    login_as user

    visit root_path
    click_on 'Delete'

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Your deal was successfully destroyed!')
    expect(page).to have_content('Current Deals Value')
    expect(page).to have_no_css('td', text: 'Founders Brewery')
    expect(page).to have_no_css('td', text: 'Multi Million Dollars Sale')
    expect(page).to have_no_css('td', text: 'Pending')
    expect(page).to have_no_css('td', text: 'US$ 7,5 M')
    expect(page).to have_content("You don't have any deals yet. Create your first deal!")
    expect(Deal.count).to eq 0
  end
end
