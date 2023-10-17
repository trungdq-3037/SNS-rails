class Api::V1::LikeController < ApplicationController
  before_action :set_like, only: [:create, :destroy]
  def create
    unless @like.nil?
      return render json: {
        success: false,
        message: 'Something went wrong'
      }, status: :bad_request
    end

    like = Like.new(like_params)

    if like.save
      render json: {
        success: true,
        message: 'liked'
      }
    else
      render json: {
        success: false,
        message: 'Something went wrong'
      }, status: :bad_request
    end
  end

  def destroy
    if @like.nil?
      return render json: {
        success: false,
        message: 'Something went wrong'
      }, status: :bad_request
    end
    @like.destroy
    render json: {
      success: true,
      message: 'unlike'
    }
  end

  private

  def like_params
    { post_id: params[:post_id], user_id: @current_user.id }
  end

  def set_like
    @like = Like.find_by(like_params)
  rescue StandardError => e
    @like = nil
  end
end
