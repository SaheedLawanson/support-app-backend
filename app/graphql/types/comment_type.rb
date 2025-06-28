module Types
    class CommentType < Types::BaseObject
      field :id, ID, null: false
      field :user, Types::UserType, null: false
      field :support_request, Types::SupportRequestType, null: false
      field :text, String
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    end
  end
  