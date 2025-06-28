# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    private

    def current_user
      context[:current_user]
    end

    def authenticate_user!
      unless current_user
        raise GraphQL::ExecutionError, "Unauthorized"
      end
      current_user
    end

    def authenticate_customer!
      user = authenticate_user!
      unless user.role == "CUSTOMER"
        raise GraphQL::ExecutionError, "Unauthorized"
      end
      user
    end

    def authenticate_agent!
      user = authenticate_user!
      unless user.role == "AGENT"
        raise GraphQL::ExecutionError, "Unauthorized"
      end
      user
    end
  end
end
