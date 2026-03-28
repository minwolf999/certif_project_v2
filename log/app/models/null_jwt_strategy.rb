# frozen_string_literal: true

class NullJwtStrategy
  @revoked_jtis = {}
  @mutex = Mutex.new

  class << self
    def revoked_jtis
      @revoked_jtis
    end

    def mutex
      @mutex
    end

    def jwt_revoked?(payload, user)
      jti = payload && payload["jti"]
      return false unless jti
      now = Time.now.to_i
      mutex.synchronize do
        revoked_jtis.delete_if { |_, exp| exp && exp < now }
        revoked_jtis.key?(jti)
      end
    end

    def revoke_jwt(payload, user)
      jti = payload && payload["jti"]
      return unless jti
      exp = payload["exp"]
      mutex.synchronize do
        revoked_jtis[jti] = exp
      end
    end
  end
end
