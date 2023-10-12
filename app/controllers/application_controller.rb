class ApplicationController < ActionController::API
    before_action :set_default_format, :authenticated 
    attr_reader :current_user
    SECRET_KEY= ENV['SECRET_KEY']

    def authenticated
        begin
        un_authorized_res = {json: {
            success: false,
            message: "UnAuthenticated"
        }}
        return render un_authorized_res if auth_token.blank?

        decoded= JWT.decode auth_token, SECRET_KEY
        @current_user = User.find(decoded[0]['id'])
        return render un_authorized_res if current_user.nil?

        rescue
            return render un_authorized_res 
        end
    end

    

    private
    def auth_token
        @auth_token ||= request.headers.fetch("Authorization", "").split(" ").last
      end
    
    def set_default_format
        request.format = :json
    end
  

end
