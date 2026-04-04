class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  after_action :raise_on_empty_response

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :honorific, :email, :password, :password_confirmation)
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:first_name, :last_name, :honorific, :email, :password, :current_password)
    end

    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])
  end

  def raise_on_empty_response
    return unless Rails.env.development?

    if response.status == 204
      raise "No template rendered for #{controller_name}##{action_name}"
    end
  end
end
