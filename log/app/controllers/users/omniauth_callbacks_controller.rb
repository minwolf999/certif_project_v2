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

      if user.present?
        sign_out_all_scopes
        flash[:success] = t('devise.omniauth_callbacks.success', kind:)
        sign_in_and_redirect user, event: :authentication
      else
        reason = "#{auth.info.email} is not authorized."
        reason = t('devise.omniauth_callback.email_not_verified', kind:) if auth.info.email.nil?

        flash[:alert] = t('devise.omniauth_callbacks.failure', kind:, reason:)
        redirect_to new_session_path(:user)
      end
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end
  end
end
