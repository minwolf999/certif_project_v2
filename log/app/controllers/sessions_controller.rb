# frozen_string_literal: true

class SessionsController < ApplicationController
  def redirect_to_sign_in
    redirect_to new_user_session_path
  end

  def send_otp
    @user = User.find_by(email: otp_params[:email])
    return redirect_to new_user_session_path, alert: I18n.t('devise.failure.invalid') unless @user&.valid_password?(otp_params[:password])

    if @user.otp_already_give?
      sign_in(@user)
      redirect_to after_sign_in_path_for(@user)
      return
    end

    UserMailer.with(user: @user).otp.deliver_later
    flash.now[:notice] = I18n.t('devise.sessions.otp_sent')
    @display_otp = true
    @password = otp_params[:password]
    render 'devise/sessions/new'
  end

  private

  def otp_params
    params.require(:user).permit(:email, :password, :remember_me)
  end
end
