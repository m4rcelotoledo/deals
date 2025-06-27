# frozen_string_literal: true

require 'rails_helper'

feature 'User set a deal as lost' do
  scenario 'successfully' do
    user = create(:user)
    deal = create(:deal, user: user)
    login_as user

    visit root_path
    click_on 'Lost'

    deal.reload
    expect(page).to have_content('Your deal was Lost!')
    expect(page).to have_content("Current Deals Value\n#{deal.value}")
    expect(page).to have_css('td', text: deal.customer)
    expect(page).to have_css('td', text: deal.description)
    expect(page).to have_no_css('td', text: 'Pending')
    expect(page).to have_css('td', text: deal.status.camelcase)
    expect(page).to have_css('td', text: deal.closing_date_probability)
    expect(page).to have_css('td', text: deal.value)
    expect(deal).to be_lost
  end
end
