# frozen_string_literal: true

module Types
  class SupportRequestType < Types::BaseObject
    field :id, ID, null: false
    field :reference, String
    field :request_type, Types::RequestTypeEnum
    field :subject, String
    field :description, String
    field :attachments, [String], null: true
    field :status, Types::RequestStatusEnum
    field :customer, Types::UserType
    field :agent, Types::UserType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
