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
class User < ApplicationRecord
  devise :database_authenticatable, :two_factor_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
         :jwt_authenticatable, :omniauthable, jwt_revocation_strategy: NullJwtStrategy, omniauth_providers: [:google_oauth2]

  def otp_recently_sent?
    otp_sent_at.present? && otp_sent_at > 2.minutes.ago
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
