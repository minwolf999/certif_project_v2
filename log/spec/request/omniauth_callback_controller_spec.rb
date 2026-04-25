# frozen_string_literal: true

require 'rails_helper'
require 'omniauth'
require 'omniauth/auth_hash'

RSpec.describe "OmniauthCallbacks", type: :request do
  let(:auth_hash) do
    OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      info: { email: "test@example.com", name: 'test' }
    })
  end

  before do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      info: { email: "test@example.com", name: 'test' }
    })
  end

  it "signs in user when found" do
    user = create(:user)
    allow(User).to receive(:from_omniauth).and_return(user)

    get "/users/auth/google_oauth2/callback"

    expect(response).to redirect_to(root_url)
  end

  it "redirects when user not found" do
    allow(User).to receive(:from_omniauth).and_return(nil)

    get "/users/auth/google_oauth2/callback"

    expect(response).to have_http_status(:unauthorized)
  end
end
