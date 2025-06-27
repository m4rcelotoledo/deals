# frozen_string_literal: true

require 'rails_helper'

feature 'Create a user' do
  scenario 'can access page' do
    path = '/users/password/new'
    visit root_path

    expect(page).to have_css('h2', text: 'Log in')
    expect(page).to have_css('label', text: 'Email')
    expect(page).to have_css('label', text: 'Password')
    expect(page).to have_link('Sign up', href: '/users/sign_up')
    expect(page).to have_link('Forgot your password?', href: path)
    expect(page).to have_no_content('Logout')
  end

  scenario 'successfully' do
    visit new_user_registration_path
    fill_in 'Email', with: 'new@email.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_css('span', text: 'new@email.com')
    expect(page).to have_no_content('Log in')
    expect(page).to have_content("You don't have any deals yet. Create your first deal!")
    expect(page).to have_content('+ Create New Deal')
  end

  scenario 'and dont fill' do
    visit root_path
    click_on 'Sign up'
    click_on 'Sign up'

    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario 'and wrong login' do
    user = create(:user)

    visit root_path
    fill_in 'Email', with: 'wrong@email'
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content('Invalid Email or password')
  end

  scenario 'and login successfully' do
    user = create(:user)

    visit root_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_css('span', text: user.email)
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content(user.email)
    expect(page).to have_no_content('Log in')
  end
end
