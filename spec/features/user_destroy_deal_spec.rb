# frozen_string_literal: true

require 'rails_helper'

feature 'User destroy a deal' do
  scenario 'successfully' do
    user = create(:user)
    create(:deal, user: user)
    login_as user

    visit root_path
    click_on 'Destroy'

    expect(page).to have_content('Your deal was successfully destroyed!')
    expect(page).to have_content('Current Deals:')
    expect(page).to have_no_css('td', text: 'Founders Brewery')
    expect(page).to have_no_css('td', text: 'Multi Million Dollars Sale')
    expect(page).to have_no_css('td', text: 'Pending')
    expect(page).to have_no_css('td', text: 'US$ 7,5 M')
    expect(page).to have_content("Don't have deals yet")
  end

  xscenario 'should cant delete deals from other users' do
    # pending
  end
end
