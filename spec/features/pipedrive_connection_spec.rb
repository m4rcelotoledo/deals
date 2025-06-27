# frozen_string_literal: true

require 'rails_helper'

feature 'Connection with Pipeline via API' do
  scenario 'open modal to connection' do
    user = create(:user)
    login_as user
    visit root_path

    click_on 'Import From Pipedrive'

    expect(page).to have_css('h5', text: 'Import Deals From Pipedrive')
    find(:label, text: 'Pipedrive API Token')
    check 'importOpen'
    check 'importLost'
    find(:field, 'apiToken', type: 'password', placeholder: 'Enter your API token')
    expect(page).to have_link('Where can I find my API token?')
    expect(page).to have_button('Import Deals')
    expect(page).to have_button('Cancel')
  end

  scenario 'connection established' do
    skip 'Needs to be implemented'
  end
end
