module Resolvers
  class GetRequestStatusesResolver < BaseResolver
    type [Types::RequestStatusEnum], null: false

    def resolve
      # Return all statuses from the enum
      ::SupportRequest.statuses.keys.map(&:upcase)
    end
  end
end 