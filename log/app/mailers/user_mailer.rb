# frozen_string_literal: true

class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def otp
    @user = params[:user]
    @otp = @user.current_otp

    mail(to: @user.email, subject: t('.otp'))
  end
end
