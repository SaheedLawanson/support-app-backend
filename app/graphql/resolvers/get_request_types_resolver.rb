module Resolvers
  class GetRequestTypesResolver < BaseResolver
    type [Types::RequestTypeEnum], null: false

    def resolve
      # Return all request types from the enum
      ::SupportRequest.request_types.keys.map(&:upcase)
    end
  end
end 