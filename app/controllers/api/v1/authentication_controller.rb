# require "../concerns/json_web_token.rb"
# include JsonWebToken

class Api::V1::AuthenticationController < ApplicationController
    skip_before_action :authenticated
    SECRET_KEY= ENV['SECRET_KEY']

    def create
        @user = User.find_by(email: login_params[:email])
        if @user.present? and @user.authenticate(login_params[:password])
            token = JWT.encode( {id: @user.id, username: @user.username} , SECRET_KEY)
            return render json: {
                message: 'Authentication successful',
                data: token,
                success: true,
            }
        else
            return render json: {
                success: false,
                message: 'Invalid username or password',
            } , status: :bad_request
        end

    end

    private
    def login_params
        params.permit(:email, :password)
    end


end
