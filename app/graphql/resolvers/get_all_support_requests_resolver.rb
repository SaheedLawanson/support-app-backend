module Resolvers
    class GetAllSupportRequestsResolver < BaseResolver
        type [Types::SupportRequestType], null: false

        argument :filter, Types::SupportRequestFilterType, required: false
        argument :limit, Integer, required: false, default_value: 10
        argument :offset, Integer, required: false, default_value: 0

        def resolve(filter: nil, limit: 10, offset: 0)
            user = authenticate_agent!

            if limit > 20 || limit < 1
                raise GraphQL::ExecutionError, "Limit must be between 1 and 20"
            end

            if offset < 0
                raise GraphQL::ExecutionError, "Offset must be 0 or greater"
            end

            support_requests = ::SupportRequest.all

            if filter
                support_requests = support_requests.where(filter.to_h)
            end

            support_requests.limit(limit).offset(offset).order(:created_at)
        end
    end
end