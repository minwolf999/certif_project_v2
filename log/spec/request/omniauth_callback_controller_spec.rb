# frozen_string_literal: true

RSpec.describe "OmniauthCallbacks", type: :request do
  let(:auth_hash) do
    OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      info: { email: "test@example.com" }
    })
  end

  before do
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      info: { email: "test@example.com" }
    })
  end

  it "signs in user when found" do
    user = create(:user)
    allow(User).to receive(:from_omniauth).and_return(user)

    get "/users/auth/google_oauth2/callback"

    expect(response).to redirect_to(root_path)
  end

  it "redirects when user not found" do
    allow(User).to receive(:from_omniauth).and_return(nil)

    get "/users/auth/google_oauth2/callback"

    expect(response).to redirect_to(new_user_session_path)
  end

  it "handles missing email" do
    auth_hash.info.email = nil
    allow(User).to receive(:from_omniauth).and_return(nil)

    get "/users/auth/google_oauth2/callback"

    expect(flash[:alert]).to be_present
  end
end
