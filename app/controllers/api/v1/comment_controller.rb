class Api::V1::CommentController < ApplicationController
  before_action :set_comment, only: [:destroy, :update]
  before_action :own_comment, only: [:destroy, :update]

  def create
    @comment = Comment.new(create_params)
    if @comment.save
      render :create
    else
      render json: {
        success: false,
        message: 'Cant create comment'
      },status:  :bad_request
    end
    # if Comment.create(create_params) # wil return a object so it always go to true block
    # to fix  add ! -> Comment.create!(create_params)
    #     render :create
    # else
    #     render json: {
    #         success: false,
    #         message: exception
    #     }
    # end
    # begin
    #     Comment.create!(create_params)
    # rescue => exception
    #     render json: {
    #         success: false,
    #         message: exception
    #     }
    # end
  end

  def update
    if @comment.update(update_params)
      render :update
    else
      render json: { success: false, error: @comment.errors.full_messages }
    end
  end

  def destroy
    @comment.destroy
    render :destroy
  end

  private

  def create_params
    { **params.permit(:comment_text, :post_id).to_h, user_id: @current_user.id }
  end

  def update_params
    params.permit(:comment_text)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  rescue StandardError => e
    render json: { message: e, success: false }, status: :bad_request
  end

  def own_comment
    render json: { message: 'Not own this post', success: false }, status: :bad_request unless @current_user.id == @comment.user_id
  end
end
