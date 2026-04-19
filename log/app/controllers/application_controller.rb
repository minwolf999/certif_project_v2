class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user_from_jwt!, unless: :devise_controller?

  skip_before_action :verify_authenticity_token

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

  def authenticate_user_from_jwt!
    auth_header = cookies['culture_g']
    if auth_header.nil?
      redirect_to new_user_session_path
      return
    end

    token = auth_header.split(' ').last

    begin
      payload, = JWT.decode(
        token,
        ENV['DEVISE_JWT_SECRET_KEY'] || Rails.application.credentials.devise_jwt_secret_key!,
        true,
        algorithm: 'HS256'
      )

      @current_user = User.find_by(id: payload['sub'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      @current_user = nil
    ensure
      redirect_to new_user_session_path if @current_user.nil?
    end
  end

  def current_user
    @current_user
  end
end
