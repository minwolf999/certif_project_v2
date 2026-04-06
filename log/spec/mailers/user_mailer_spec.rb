# frozen_string_literal: true

RSpec.describe UserMailer, type: :mailer do
  describe "#otp" do
    let(:user) { build(:user) }

    before do
      allow(user).to receive(:current_otp).and_return("123456")
    end

    subject(:mail) { described_class.with(user: user).otp }

    it "sends to the correct recipient" do
      expect(mail.to).to eq([ user.email ])
    end

    it "has the correct subject" do
      expect(mail.subject).to eq(I18n.t("user_mailer.otp.otp"))
    end

    it "assigns user and otp" do
      expect(mail.body.encoded).to include("123456")
    end
  end
end
