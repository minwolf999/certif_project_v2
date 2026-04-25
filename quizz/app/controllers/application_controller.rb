class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!

  private

  def authenticate_user!
    token = cookies['culture_g']
    if token.present?
      payload, = JWT.decode(
        token,
        ENV['DEVISE_JWT_SECRET_KEY'] || Rails.application.credentials.devise_jwt_secret_key!,
        true,
        algorithm: 'HS256'
      )

      @current_user = payload['user']
      @current_user = @current_user&.transform_keys(&:to_sym)
    end
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    @current_user = nil
  ensure
    redirect_to '/users/sign_in' if @current_user.nil?
  end
end
