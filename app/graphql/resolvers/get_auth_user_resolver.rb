module Resolvers
    class GetAuthUserResolver < BaseResolver
        type Types::UserType, null: false

        def resolve()
            # Require authentication to access user details
            authenticate_customer!
            user = context[:current_user]
            user
        end
    end
end