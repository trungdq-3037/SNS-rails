class Api::V1::CommentController < ApplicationController
    before_action :set_comment , only: [:destroy, :update]
    before_action :own_comment , only: [:destroy, :update]


    def create
        @comment = Comment.new(create_params)
        if @comment.save
                render :create
        else
            render json: {
                success: false,
                message: "Cant create comment"
            }
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

    def destroy
            @comment.destroy
            render :destroy
    end

    def update
        if @comment.update(update_params)
            render :update
        else
            render json: {success: false, error: @comment.errors.full_messages}
        end
    end

    private
    def create_params
        return { **params.permit(:comment_text, :post_id).to_h , user_id: @current_user.id}
    end

    def update_params
        return params.permit(:comment_text)
    end


    def set_comment
        begin
            @comment = Comment.find(params[:id])
        rescue => exception
            render json: { message: exception, success: false}
        end
    end

    def own_comment
        return  render json: { message: "Not own this post", success: false} unless @current_user.id == @comment.user_id
    end


end
