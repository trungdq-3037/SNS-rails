class Api::V1::PostController < ApplicationController
    before_action :set_post , only: [ :update, :show, :destroy]
    before_action :own_post , only: [ :update, :destroy]
    def index
        @posts = Post.all().includes(:comments,:user)
        return render :index
    end

    def show
        return render :show
    end

    def update
        if  @post.update(update_params)
            return render :update
        else
            return render json:
            {
                success: false,
                message: "An error has occurred while updating"
            }
        end
    end

    def destroy
        if @post.destroy
            return render :destroy
        else
            return render json:
            {
                success: false,
                message: "An error has occurred while delete"
            }
        end

    end



    def create
        post = Post.new( user_id: @current_user.id, content: create_params[:content] )
        if post.save
            return render json: {
                success: true,
                message: "created successfully",
                data: post
            }
        else
            return render json: {
                success: false,
                message: "failed to create post"
            }
        end
    end
    private

    def create_params
        params.permit :content
    end

    def update_params
        params.permit :content
    end

    def set_post
        begin
            @post = Post.find(params[:id])
        rescue => exception
            return render json: {
                success: false,
                message: exception
            }
        end
    end

    def own_post
        return render json: {
            success: false,
            message: "you are not owning post"
        }  unless @current_user.id == @post.user_id
    end

end
