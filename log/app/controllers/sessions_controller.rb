# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def create
    super do
      if session[:user_return_to].present?
        current_user.update_column(:otp_already_give, true)
        ResetOtpRequiredToTrue.set(wait: 3.hours).perform_later(user_id: current_user.id)

        redirect_to session[:user_return_to]
        session[:user_return_to] = nil
        return
      end
    end
  end

  def redirect_to_sign_in
    redirect_to new_user_session_path
  end

  def send_otp
    @user = User.find_by(email: otp_params[:email])

    unless @user&.valid_password?(otp_params[:password])
      return redirect_to new_user_session_path, alert: I18n.t('devise.failure.invalid')
    end

    if @user.otp_secret.nil?
      @user.update(otp_secret: User.generate_otp_secret, otp_required_for_login: true)
    end

    UserMailer.with(user: @user).otp.deliver_later

    flash.now[:notice] = "OTP sent (or resent)"
    @display_otp = true
    @password = otp_params[:password]

    render 'devise/sessions/new'
  end

  private

  def otp_params
    params.require(:user).permit(:email, :password, :remember_me)
  end
end
