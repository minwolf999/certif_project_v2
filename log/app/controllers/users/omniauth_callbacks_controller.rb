# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      handle_omniauth(kind: 'Google')
    end

    def discord
      handle_omniauth(kind: 'Discord')
    end

    def github
      handle_omniauth(kind: 'Github')
    end

    private

    def handle_omniauth(kind:)
      user = User.from_omniauth(auth)

      unless user
        reason = if auth.info.email.nil?
                   t('devise.omniauth_callbacks.email_not_verified', kind:)
                 else
                   t('devise.omniauth_callbacks.email_not_authorized', email: auth.info.email)
                 end

        return render json: { error: reason }, status: :unauthorized
      end

      sign_in(user, store: false)
      request.session_options[:skip] = true
      reset_session

      cookies[:culture_g] = request.env['warden-jwt_auth.token']
      redirect_to root_url
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end
end
