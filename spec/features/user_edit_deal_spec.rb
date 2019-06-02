require 'rails_helper'

feature 'User edit a deal' do
  scenario 'successfully' do
    user = create(:user)
    create(:deal, user: user)
    login_as user
    closing_date_probability = (Time.zone.today + 25.days).strftime('%d/%m/%Y')

    visit root_path
    click_on 'Edit'
    fill_in 'Customer', with: 'Founders Brewery'
    fill_in 'Description', with: 'Multi Million Dollars Sale'
    fill_in 'Closing Date / Probability', with: closing_date_probability
    fill_in 'Value', with: 'US$ 7,5 M'
    click_on 'Update Deal'

    expect(page).to have_content('Your deal successfully updated!')
    expect(page).to have_content('Current Deals: US$ 7,5 M')
    expect(page).to have_css('td', text: 'Founders Brewery')
    expect(page).to have_css('td', text: 'Multi Million Dollars Sale')
    expect(page).to have_css('td', text: 'Pending')
    expect(page).to have_css('td', text: closing_date_probability)
    expect(page).to have_css('td', text: 'US$ 7,5 M')
  end

  scenario 'fail' do
    user = create(:user)
    create(:deal, user: user)
    login_as user

    visit root_path
    click_on 'Edit'
    fill_in 'Customer', with: ''
    click_on 'Update Deal'

    expect(page).to have_content('You need to fill all fields!')
  end

  xscenario 'should cant edit deals from other users' do
  end
end
