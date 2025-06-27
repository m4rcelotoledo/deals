# frozen_string_literal: true

require 'rails_helper'

feature 'User add a new deal' do
  scenario 'successfully' do
    user = create(:user)
    login_as user
    closing_date_probability = (Time.zone.today + 30.days).strftime('%d/%m/%Y')

    visit root_path
    fill_in 'Customer', with: 'Founders Brewery'
    fill_in 'Description', with: 'Multi Million Dollars Sale'
    fill_in 'Value', with: 'US$ 7,5 M'
    click_on 'Create Deal'

    expect(page).to have_content('Your deal was successfully sent!')
    expect(page).to have_content('Current Deals Value')
    expect(page).to have_css('p', text:  'US$ 7,5 M')
    expect(page).to have_css('td', text: 'Founders Brewery')
    expect(page).to have_css('td', text: 'Multi Million Dollars Sale')
    expect(page).to have_css('td', text: 'Pending')
    expect(page).to have_css('td', text: closing_date_probability)
    expect(page).to have_css('td', text: 'US$ 7,5 M')
  end

  scenario 'fail' do
    user = create(:user)
    login_as user

    visit root_path
    click_on 'Create Deal'

    expect(page).to have_content('You need to fill all fields!')
  end
end
