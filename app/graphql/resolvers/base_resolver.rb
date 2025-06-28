# frozen_string_literal: true

module Resolvers
  class BaseResolver < GraphQL::Schema::Resolver
    private

    def authenticate_user!
      current_user = context[:current_user]
      unless current_user
        raise GraphQL::ExecutionError, "Unauthorized"
      end
      current_user
    end

    def authenticate_customer!
      current_user = context[:current_user]
      puts "current_user: #{current_user.inspect}"
      unless current_user&.role == "CUSTOMER"
        raise GraphQL::ExecutionError, "Unauthorized"
      end
      current_user
    end

    def authenticate_agent!
      current_user = context[:current_user]
      unless current_user&.role == "AGENT"
        raise GraphQL::ExecutionError, "Unauthorized"
      end
      current_user
    end
  end
end
