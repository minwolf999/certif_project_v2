# frozen_string_literal: true

class NullJwtStrategy
  def self.jwt_revoked?(payload, user)
    false
  end

  def self.revoke_jwt(payload, user); end
end
