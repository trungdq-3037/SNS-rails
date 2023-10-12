class Api::V1::LikeController < ApplicationController
    before_action :set_like , only: [:create, :destroy]
    def create
        return  render json: {
            success: false,
            message: "Something went wrong"
        }, status: :bad_request  unless @like.nil?

        like = Like.new(like_params)

        if  like.save
            return render json: {
                success: true,
                message: "liked"
            }
        else
            return render json: {
                success: false,
                message: "Something went wrong"
            }, status: :bad_request 
        end
    end

    def destroy
        return  render json: {
            success: false,
            message: "Something went wrong"
        }, status: :bad_request  if @like.nil?
        @like.destroy
        render json: {
            success: true,
            message: "unlike"
        }
    end

    private
    def like_params
        return { post_id: params[:post_id] , user_id: @current_user.id}
    end

    def set_like
        begin
            @like = Like.find_by( like_params )
        rescue => exception
            @like = nil
        end
    end


end
