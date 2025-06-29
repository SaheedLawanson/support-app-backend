# frozen_string_literal: true
require "jwt"

module Mutations
  class SignIn < BaseMutation
    field :token, String, null: true

    argument :email, String, required: true
    argument :password, String, required: true

    def resolve(email:, password:)
      user = User.find_by(email: email)

      unless user && user.password == password
        raise GraphQL::ExecutionError, "Invalid email or password"
      end

      hmac_secret = ENV["JWT_SECRET"]
      token = JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, hmac_secret, "HS256")

      { token: token }
    end
  end
end
