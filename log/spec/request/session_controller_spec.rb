# frozen_string_literal: true

RSpec.describe "Sessions OTP", type: :request do
  let(:user) { create(:user, password: "password123") }

  describe "POST /send_otp" do
    let(:params) do
      {
        user: {
          email: user.email,
          password: "password123"
        }
      }
    end

    context "when password is invalid" do
      it "redirects with alert" do
        post send_otp_path, params: { user: params[:user].merge(password: "wrong") }

        expect(response).to redirect_to(new_user_session_path)
        expect(flash[:alert]).to be_present
      end
    end

    context "when OTP already sent" do
      it "does not resend OTP" do
        allow_any_instance_of(User).to receive(:otp_recently_sent?).and_return(true)

        post send_otp_path, params: params

        expect(response.body).to include(I18n.t("sessions.send_otp.otp_already_sent"))
      end
    end

    context "when sending OTP first time" do
      it "updates user and sends mail" do
        allow(UserMailer).to receive_message_chain(:with, :otp, :deliver_later)

        post send_otp_path, params: params

        user.reload
        expect(user.otp_required_for_login).to be true
        expect(user.otp_sent_at).to be_present
      end
    end
  end
end
