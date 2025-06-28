# frozen_string_literal: true

module Mutations
  class UpdateSupportRequestStatus < BaseMutation
    field :support_request, Types::SupportRequestType, null: true
    field :error, String, null: true

    argument :id, ID, required: true
    argument :status, Types::RequestStatusEnum, required: true

    def resolve(id:, status:)
      # Require agent authentication
      user = authenticate_agent!
      
      support_request = ::SupportRequest.find(id)
      
      if support_request.nil?
        raise GraphQL::ExecutionError, "Support request not found"
      end

      if support_request.agent_id != user.id
        raise GraphQL::ExecutionError, "This support request is not assigned to you"
      end

      if support_request.update(status: status)
        { support_request: support_request }
      else
        raise GraphQL::ExecutionError, support_request.errors.full_messages[0]
      end
    end
  end
end 