class Api::V1::UserController < ApplicationController

    def create
        @user = User.create(user_create_params)
        if @user.save()
            return render json: {
                success: true ,
                data: user_create_params[:email]
             }
        else
            return render json: {
                success: false,
                message: @user.errors.full_messages
            }
        end
    end

    private
    def user_create_params
        params.permit(:email, :password, :password_confirmation, :username)
    end

end
