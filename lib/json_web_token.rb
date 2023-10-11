class JsonWebToken
    SECRET_KEY = "Aa@123456"
    def self.encode payload
        JWT.encode payload, SECRET_KEY
    end
    def self.decode token
        decoded = JWT.decode(token, SECRET_KEY).first
        HashWithIndifferentAccess.new decoded
    end
end