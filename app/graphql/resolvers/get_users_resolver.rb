module Resolvers
    class GetUsersResolver < BaseResolver
        type [Types::UserType], null: false
        argument :limit, Integer, required: false, default_value: 10
        argument :offset, Integer, required: false, default_value: 0

        def resolve(limit: 10, offset: 0)
            authenticate_agent!

            if limit > 20 || limit < 1
                raise GraphQL::ExecutionError, "Limit must be between 1 and 20"
            end

            if offset < 0
                raise GraphQL::ExecutionError, "Offset must be 0 or greater"
            end

            ::User.all.limit(limit).offset(offset).order(created_at: :desc)
        end
    end
end