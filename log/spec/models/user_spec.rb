# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  consumed_timestep      :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  otp_required_for_login :boolean          default(FALSE), not null
#  otp_secret             :string
#  otp_sent_at            :datetime
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'
require 'ostruct'

RSpec.describe User, type: :model do
  describe '#otp_recently_sent?' do
    let(:user) { build(:user) }

    it 'returns false if otp_sent_at is nil' do
      user.otp_sent_at = nil
      expect(user.otp_recently_sent?).to be false
    end

    it 'returns false if otp_sent_at is older than 2 minutes' do
      user.otp_sent_at = 5.minutes.ago
      expect(user.otp_recently_sent?).to be false
    end

    it 'returns true if otp_sent_at is within 2 minutes' do
      user.otp_sent_at = 1.minute.ago
      expect(user.otp_recently_sent?).to be true
    end
  end

  describe '.from_omniauth' do
    let(:auth) do
      OpenStruct.new(
        provider: 'google_oauth2',
        info: OpenStruct.new(email: 'test@example.com')
      )
    end

    it 'creates a new user if one does not exist' do
      expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
      user = User.last
      expect(user.email).to eq('test@example.com')
      expect(user.provider).to eq('google_oauth2')
      expect(user.confirmed?).to be true
    end

    it 'returns existing user if email already exists' do
      existing_user = create(:user, email: 'test@example.com')
      user = User.from_omniauth(auth)
      expect(user.id).to eq(existing_user.id)
      expect(user.provider).to eq('google_oauth2')
    end

    it 'returns nil if email is nil in auth' do
      auth.info.email = nil
      expect(User.from_omniauth(auth)).to be_nil
    end
  end
end
