class Api::V1::HelloWorldController < ApplicationController
  # skip_before_action  :authenticated, only: [:index]
  def index
    render json: {
      success: true,
      message: 'Hello World'
    }
  end
end
