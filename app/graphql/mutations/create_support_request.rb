# frozen_string_literal: true

module Mutations
  class CreateSupportRequest < BaseMutation
    field :support_request, Types::SupportRequestType, null: true

    argument :subject, String, required: true
    argument :description, String, required: true
    argument :request_type, Types::RequestTypeEnum, required: true
    argument :attachments, [String], required: false

    def resolve(subject:, description:, request_type:, attachments: [])
      # Require authentication to create a support request
      user = authenticate_user!
      
      # Only customers can create support requests
      unless user.role == "CUSTOMER"
        raise GraphQL::ExecutionError, "Only customers can create support requests"
      end

      support_request = ::SupportRequest.new(
        subject: subject,
        description: description,
        request_type: request_type,
        customer_id: user.id,
        attachments: attachments,
        status: "PENDING"
      )

      if support_request.save
        { support_request: support_request }
      else
        raise GraphQL::ExecutionError, support_request.errors.full_messages[0]
      end
    end
  end
end 