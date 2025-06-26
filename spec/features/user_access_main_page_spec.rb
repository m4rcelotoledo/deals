# frozen_string_literal: true

require 'rails_helper'

feature 'User access main page' do
  scenario 'and dont have deals to show' do
    user = create(:user)
    login_as user
    visit root_path

    expect(page).to have_content('+ Deals:')
    expect(page).to have_content('Customer:')
    expect(page).to have_content('Description:')
    expect(page).to have_content('Value:')
    expect(page).to have_button('Create Deal')
    expect(page).to have_button('Import Deals From Pipedrive')
    expect(page).to have_content('Current Deals:')
    expect(page).to have_button('Search')
    expect(page).to have_content("Don't have deals yet")
  end

  scenario 'successfully' do
    user = create(:user)
    deal = create(:deal, user: user)
    login_as user
    visit root_path

    expect(page).to have_button('Import Deals From Pipedrive')
    expect(page).to have_content("Current Deals: #{deal.value}")
    expect(page).to have_button('Search')
  end

  scenario 'should see your deals' do
    user = create(:user)
    deal = create(:deal, user: user)
    deal2 = create(:deal, customer: 'W&B',
                          description: 'Multi Million Dollars Sale',
                          status: 1, closing_date_probability: 'In 25 days 70%',
                          value: 'US$ 2,5 M', user: user)
    deal3 = create(:deal, customer: 'Brand',
                          description: 'Multi Thousand Dollars Sale',
                          status: 2, closing_date_probability: '03/02/2018',
                          value: 'US$ 2,5 K', user: user)
    login_as user

    visit root_path

    expect(page).to have_css('th', text: 'Customer')
    expect(page).to have_css('th', text: 'Description')
    expect(page).to have_css('th', text: 'Status')
    expect(page).to have_css('th', text: 'Closing Date/Probability')
    expect(page).to have_css('th', text: 'Value')
    expect(page).to have_css('th', text: 'Actions')
    expect(page).to have_css('td', text: deal.customer)
    expect(page).to have_css('td', text: deal.description)
    expect(page).to have_css('td', text: deal.status.camelcase)
    expect(page).to have_css('td', text: deal.closing_date_probability)
    expect(page).to have_css('td', text: deal.value)
    expect(page).to have_css('td', text: 'Edit | Destroy | Won | Lost')
    expect(page).to have_css('td', text: deal2.customer)
    expect(page).to have_css('td', text: deal2.description)
    expect(page).to have_css('td', text: 'Won')
    expect(page).to have_css('td', text: deal2.closing_date_probability)
    expect(page).to have_css('td', text: deal2.value)
    expect(page).to have_css('td', text: 'Edit | Destroy | Won | Lost')
    expect(page).to have_css('td', text: deal3.customer)
    expect(page).to have_css('td', text: deal3.description)
    expect(page).to have_css('td', text: deal3.status.camelcase)
    expect(page).to have_css('td', text: deal3.closing_date_probability)
    expect(page).to have_css('td', text: deal3.value)
    expect(page).to have_css('td', text: 'Edit | Destroy | Won | Lost')
  end

  scenario 'should cant view deals from other users' do
    another_user = create(:user, email: 'other@email.com', password: '123456')
    another_deal = create(:deal, user: another_user)
    user = create(:user)
    deal1 = create(:deal, customer: 'W&B',
                          description: 'Multi Million Dollars Sale',
                          status: 1, closing_date_probability: 'In 25 days 70%',
                          value: 'US$ 2,5 M', user: user)
    deal2 = create(:deal, customer: 'Brand',
                          description: 'Multi Thousand Dollars Sale',
                          status: 2, closing_date_probability: '03/02/2018',
                          value: 'US$ 2,5 K', user: user)
    login_as user

    visit root_path

    expect(page).to have_css('td', text: deal1.customer)
    expect(page).to have_css('td', text: deal2.customer)
    expect(page).to have_no_css('td', text: another_deal.customer)
    expect(page).to have_no_css('td', text: another_deal.description)
    expect(page).to have_no_css('td', text: another_deal.status.camelcase)
    expect(page).to have_no_css('td', text: another_deal.value)
  end
end
