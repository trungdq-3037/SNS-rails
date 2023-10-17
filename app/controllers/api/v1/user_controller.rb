class Api::V1::UserController < ApplicationController
  skip_before_action :authenticated, only: [:create]

  def show
    render :show
  end

  def create
    @user = User.create(user_create_params)
    if @user.save
      render json: {
        success: true,
        data: user_create_params[:email]
      }
    else
      render json: {
        success: false,
        message: @user.errors.full_messages
      }, status: :bad_request
    end
  end

  def update
    @current_user = User.update(user_update_params)
    render json: {
      success: true,
      data: @current_user
    }
  rescue StandardError => e
    render json: {
      success: false,
      message: e.errors.full_messages
    }, status: :bad_request
  end

  private

  def user_create_params
    params.permit(:email, :password, :password_confirmation, :username)
  end

  def user_update_params
    params.permit(:email, :password, :password_confirmation, :username)
  end
end
