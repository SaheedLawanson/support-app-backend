module Resolvers
    class GetAuthUserResolver < BaseResolver
        type Types::UserType, null: false

        def resolve()
            # Require authentication to access user details
            user = authenticate_user!
            user
        end
    end
end