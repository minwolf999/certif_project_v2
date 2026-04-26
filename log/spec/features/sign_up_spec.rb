# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'SignUps', type: :feature do
  let(:user) { build(:user) }
  let(:unconfirmed_user) { build(:user, :unconfirmed) }

  scenario 'signs up without confirmation', js: true do
    visit new_user_registration_path

    fill_in 'user_email', with: user.email
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_button 'Sign up'

    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'signs up with confirmation', js: true do
    visit new_user_registration_path

    fill_in 'user_email', with: unconfirmed_user.email
    fill_in 'user_username', with: unconfirmed_user.username
    fill_in 'user_password', with: unconfirmed_user.password
    fill_in 'user_password_confirmation', with: unconfirmed_user.password
    click_button 'Sign up'
    puts "fichiers après click : #{Dir[Rails.root.join('tmp/mails/*')].inspect}"

    user = User.last
    expect(user.confirmed?).to be false

    expect(Dir[Rails.root.join('tmp/mails/*')].size).to eq(1)

    visit user_confirmation_path(confirmation_token: user.confirmation_token)
    expect(user.reload.confirmed?).to be true
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'signs up without password', js: true do
    visit new_user_registration_path

    fill_in 'user_email', with: user.email
    click_button 'Sign up'

    expect(page).to have_current_path(new_user_registration_path, ignore_query: true)
  end

  scenario 'signs up with password confirmation error', js: true do
    visit new_user_registration_path

    fill_in 'user_email', with: user.email
    fill_in 'user_username', with: user.username
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: "#{user.password}&"
    click_button 'Sign up'

    expect(page).to have_current_path('/users')
    expect(page.body).to include('Password confirmation doesn\'t match Password')
  end
end
