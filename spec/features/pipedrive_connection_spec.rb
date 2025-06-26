# frozen_string_literal: true

require 'rails_helper'

feature 'Connection with Pipeline via API' do
  scenario 'open modal to connection' do
    user = create(:user)
    login_as user
    visit root_path

    click_on 'Import Deals From Pipedrive'

    expect(page).to have_css('h4', text: 'Import Deals From Pipedrive')
    expect(page).to have_content('Pipedrive Token:')
    expect(page).to have_button('Connect')
    select '2', from: 'Pipeline:'
    select '1', from: 'Owner:'
    expect(page).to have_content('Deals (For the Salesman Above):')
    expect(page).to have_button('Import All Selected Deals')
    expect(page).to have_button('Cancel')
  end

  scenario 'connection established' do
    skip 'Needs to be implemented'
  end
end
