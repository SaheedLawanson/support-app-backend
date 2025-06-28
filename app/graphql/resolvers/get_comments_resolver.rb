module Resolvers
    class GetCommentsResolver < BaseResolver
            type [Types::CommentType], null: false
            argument :request_id, ID, required: true
            argument :limit, Integer, required: false, default_value: 10
            argument :offset, Integer, required: false, default_value: 0

        def resolve(request_id:, limit: 10, offset: 0)
            # Require authentication to access comments
            user = authenticate_user!

            if limit > 20 || limit < 1
                raise GraphQL::ExecutionError, "Limit must be between 1 and 20"
            end

            if offset < 0
                raise GraphQL::ExecutionError, "Offset must be 0 or greater"
            end
            
            request = ::SupportRequest.find(request_id)

            if request.nil?
                raise GraphQL::ExecutionError, "Support request not found"
            end

            if user.role == "CUSTOMER" && request.customer_id != user.id
                raise GraphQL::ExecutionError, "Access denied"
            end

            comments = ::Comment.where(support_request_id: request_id).order(created_at: :desc).limit(limit).offset(offset)
            puts "GetCommentsResolver::comments: #{comments.inspect}"

            if comments.nil?
                []
            end

            comments
        end
    end
end