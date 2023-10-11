class Api::V1::HelloWorldController < ApplicationController
    def index
        return render json: {
            success: true,
            message: 'Hello World'
        }
    end

end
