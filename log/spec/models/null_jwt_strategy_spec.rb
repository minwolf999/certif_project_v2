# frozen_string_literal: true

RSpec.describe NullJwtStrategy do
  let(:payload) { { "jti" => "abc", "exp" => Time.now.to_i + 10 } }

  before do
    described_class.revoked_jtis.clear
  end

  describe ".revoke_jwt" do
    it "adds the jti to revoked list" do
      described_class.revoke_jwt(payload, nil)
      expect(described_class.revoked_jtis).to include("abc")
    end

    it "does nothing without jti" do
      described_class.revoke_jwt({}, nil)
      expect(described_class.revoked_jtis).to be_empty
    end
  end

  describe ".jwt_revoked?" do
    it "returns false when jti is not revoked" do
      expect(described_class.jwt_revoked?(payload, nil)).to be false
    end

    it "returns true when jti is revoked" do
      described_class.revoke_jwt(payload, nil)
      expect(described_class.jwt_revoked?(payload, nil)).to be true
    end

    it "cleans expired tokens" do
      expired_payload = { "jti" => "old", "exp" => Time.now.to_i - 1 }
      described_class.revoke_jwt(expired_payload, nil)

      described_class.jwt_revoked?(payload, nil)

      expect(described_class.revoked_jtis).not_to include("old")
    end
  end
end
