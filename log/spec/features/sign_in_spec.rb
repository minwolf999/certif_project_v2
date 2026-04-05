# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'SignIns', type: :feature do
  include ActiveJob::TestHelper
  let(:user) { build(:user) }

  before do
    user.save!
  end

  scenario 'signs in with otp confirmation' do
    visit new_user_session_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'

    expect(Dir[Rails.root.join('tmp/mails/*')].size).to eq(1)
    expect(page).to have_current_path(send_otp_path)

    otp_code = Mail.read(Dir[Rails.root.join('tmp/mails/*')].last).body.encoded.match(/(\d{6})/)[1]

    fill_in 'user_otp_attempt', with: otp_code
    click_button 'Sign in'

    expect(page).to have_current_path(root_path)
  end

  scenario 'signs in without password' do
    visit new_user_session_path
      
    fill_in 'user_email', with: user.email
    click_button 'Sign in'
  
    expect(page).to have_current_path(new_user_session_path, ignore_query: true)
  end
end
