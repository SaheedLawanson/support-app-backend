# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_support_request, mutation: Mutations::CreateSupportRequest
    field :update_support_request_status, mutation: Mutations::UpdateSupportRequestStatus
    field :sign_in, mutation: Mutations::SignIn
    field :create_comment, mutation: Mutations::CreateComment
  end
end
