class Api::V1::PostController < ApplicationController
  before_action :set_post, only: [:update, :show, :destroy]
  before_action :own_post, only: [:update, :destroy]

  def index
    @posts = Post.eager_load(:user, comments: :user).all.order(created_at: :desc)
    @count_comments = Comment.select('post_id, COUNT(*) as count').group(:post_id)
    @count_likes = Like.select('post_id, COUNT(*) as count').group(:post_id)
    @current_user_liked = Like.all.where(user_id: @current_user.id)
    @posts.each do |post|
      post.set_count_comment(0)
      post.set_count_like(0)
      post.set_current_user_liked(false)
      @count_comments.each do |count_comment|
        post.set_count_comment(count_comment.count) if post.id == count_comment.post_id
      end
      @count_likes.each do |count_likes|
        post.set_count_like(count_likes.count) if post.id == count_likes.post_id
      end
      @current_user_liked.each do |liked|
        post.set_current_user_liked(true) if post.id == liked.post_id
      end
    end
    render :index
  end

  def show
    render :show
  end

  def create
    post = Post.new(user_id: @current_user.id, content: create_params[:content])
    if post.save
      render json: {
        success: true,
        message: 'created successfully',
        data: post
      }
    else
      render json: {
        success: false,
        message: 'failed to create post'
      }
    end
  end

  def update
    return render :update if @post.update(update_params)

    render json:
    {
      success: false,
      message: 'An error has occurred while updating'
    }
  end

  def destroy
    return render :destroy if @post.destroy

    render json:
    {
      success: false,
      message: 'An error has occurred while delete'
    }
  end

  private

  def create_params
    params.permit :content
  end

  def update_params
    params.permit :content
  end

  def set_post
    @post = Post.find(params[:id])
  rescue StandardError => e
    render json: {
      success: false,
      message: e
    }, status: :bad_request
  end

  def own_post
    return if @current_user.id == @post.user_id

    render json: {
      success: false,
      message: 'you are not owning post'
    }, status: :bad_request
  end
end
