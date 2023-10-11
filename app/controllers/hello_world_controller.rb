class HelloWorldController < ApplicationController
    def index
        return render json: {
            success: true,
            message: 'Hello World'
        }
    end

end
