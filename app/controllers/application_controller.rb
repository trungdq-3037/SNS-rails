class ApplicationController < ActionController::API
  before_action :set_default_format, :authenticated
  attr_reader :current_user

  SECRET_KEY = ENV.fetch('SECRET_KEY', nil)

  def authenticated
    return un_authorized_res if auth_token.blank?

    decoded = JWT.decode auth_token, SECRET_KEY
    @current_user = User.find(decoded[0]['id'])
    un_authorized_res if current_user.nil?
  rescue StandardError
    un_authorized_res
  end

  private

  def auth_token
    @auth_token ||= request.headers.fetch('Authorization', '').split(' ').last
  end

  def set_default_format
    request.format = :json
  end

  def un_authorized_res
    render json: {
      success: false,
      message: 'UnAuthenticated'
    }, status: :bad_request
  end
end
