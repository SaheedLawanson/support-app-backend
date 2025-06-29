class ApplicationController < ActionController::API
    def current_user
        hmac_secret = ENV["JWT_SECRET"]
        puts "request.headers: #{request.headers['Authorization']}"
        token = request.headers["Authorization"]&.split(" ")&.last
        return nil unless token

        begin
            decoded_token = JWT.decode(token, hmac_secret, true, { algorithm: "HS256" })
        rescue JWT::DecodeError => e
            puts "JWT::DecodeError: #{e}"
            raise GraphQL::ExecutionError, "Invalid or Expired token"
        end
        
        puts "decoded_token: #{decoded_token}"
        user_id = decoded_token[0]["user_id"]
        user = User.find_by(id: user_id)

        if user.nil?
            raise GraphQL::ExecutionError, "User not found"
        end

        user
    end
end
