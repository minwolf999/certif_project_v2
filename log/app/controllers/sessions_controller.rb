# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource, store: false)

    cookies[:culture_g] = {
      value: request.env['warden-jwt_auth.token'],
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }

    redirect_to root_path
  end

  def redirect_to_sign_in
    redirect_to new_user_session_path
  end

  def send_otp
    @user = User.find_by(email: otp_params[:email])

    unless @user&.valid_password?(otp_params[:password])
      return redirect_to new_user_session_path, alert: I18n.t('devise.failure.invalid')
    end

    if @user.otp_recently_sent?
      flash.now[:alert] = t('.otp_already_sent')
      @display_otp = true
      @password = otp_params[:password]

    else
      otp_attribute = {
        otp_required_for_login: true,
        otp_sent_at: Time.current,
      }
      otp_attribute[:otp_secret] = User.generate_otp_secret if @user.otp_secret.nil?
      @user.update(otp_attribute)

      UserMailer.with(user: @user).otp.deliver_later

      flash.now[:notice] = t('.otp_sent')
      @display_otp = true
      @password = otp_params[:password]
    end

    render 'devise/sessions/new'
  end

  private

  def otp_params
    params.require(:user).permit(:email, :password, :remember_me)
  end
end
