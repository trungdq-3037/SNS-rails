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

  private

  def user_create_params
    params.permit(:email, :password, :password_confirmation, :username)
  end
end
