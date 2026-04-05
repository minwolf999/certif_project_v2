# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'SignIns', type: :feature do
  include ActiveJob::TestHelper
  let(:user) { build(:user) }

  before do
    user.save!
  end

  scenario 'signs in with otp confirmation' do
    perform_enqueued_jobs do
      visit new_user_session_path

      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Sign in'

      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(page).to have_current_path(send_otp_path)

      mail = ActionMailer::Base.deliveries.last
      otp_code = mail.body.encoded.match(/(\d{6})/)[1]

      fill_in 'user_otp_attempt', with: otp_code
      click_button 'Sign in'

      expect(page).to have_current_path('/')
    end
  end

  scenario 'signs in without password' do
    visit new_user_session_path
    
    fill_in 'user_email', with: user.email
    click_button 'Sign in'

    expect(page).to have_current_path(new_user_session_path, ignore_query: true)
  end
end
