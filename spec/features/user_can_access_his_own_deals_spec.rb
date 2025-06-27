# frozen_string_literal: true

require 'rails_helper'

feature 'User can access just his own deals' do
  scenario 'successfully' do
    user1 = create(:user)
    deal1 = create(:deal, user: user1)
    user2 = create(:user)
    deal2 = create(:deal, user: user2)
    create(:deal)
    login_as user1

    visit root_path

    expect(page).to have_css('tr', count: 2)
    expect(page).to have_content("Current Deals Value\n#{deal1.value}")
    expect(page).to have_css('td', text: deal1.customer)
    expect(page).to have_css('td', text: deal1.description)
    expect(page).to have_css('td', text: deal1.status.camelcase)
    expect(page).to have_no_css('td', text: deal2.customer)
    expect(page).to have_no_css('td', text: deal2.description)
    expect(page).to have_no_content(deal2.value)
  end

  scenario 'search just his own deals' do
    user1 = create(:user)
    deal1 = create(:deal, user: user1, description: 'My Description')
    create(:deal) # deal wherever
    deal3 = create(:deal, user: user1)
    user2 = create(:user)
    deal4 = create(:deal, user: user2, description: 'My Description')
    login_as user1

    visit root_path
    fill_in 'q', with: 'Description'
    click_on 'Search'

    expect(page).to have_css('tr', count: 2)
    expect(page).to have_content("Current Deals Value\n#{deal3.value}")
    expect(page).to have_css('td', text: deal1.customer)
    expect(page).to have_css('td', text: deal1.description)
    expect(page).to have_css('td', text: deal1.status.camelcase)
    expect(page).to have_no_css('td', text: deal4.customer)
    expect(page).to have_no_content(deal4.value)

    fill_in 'q', with: ''
    click_on 'Search'

    expect(page).to have_css('tr', count: 3)
    expect(page).to have_content("Current Deals Value\n#{deal3.value}")
    expect(page).to have_css('td', text: deal1.customer)
    expect(page).to have_css('td', text: deal1.description)
    expect(page).to have_css('td', text: deal1.status.camelcase)
    expect(page).to have_css('td', text: deal3.customer)
    expect(page).to have_css('td', text: deal3.description)
    expect(page).to have_css('td', text: deal3.status.camelcase)
    expect(page).to have_no_css('td', text: deal4.customer)
    expect(page).to have_no_content(deal4.value)
  end
end
