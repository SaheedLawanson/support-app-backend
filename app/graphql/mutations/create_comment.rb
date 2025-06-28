# frozen_string_literal: true

module Mutations
    class CreateComment < BaseMutation
      field :comment, Types::CommentType, null: true
  
      argument :text, String, required: true
      argument :support_request_id, ID, required: true
  
      def resolve(text:, support_request_id:)
        # Require authentication to create a support request
        user = authenticate_user!

        support_request = ::SupportRequest.find(support_request_id)

        if support_request.nil?
          raise GraphQL::ExecutionError, "Support request not found"
        end

        if support_request.status == "CLOSED" || support_request.status == "RESOLVED"
          raise GraphQL::ExecutionError, "Support request is closed"
        end

        if user.role == "CUSTOMER"
          if support_request.customer_id != user.id
            raise GraphQL::ExecutionError, "Unauthorized"
          end

          if support_request.status != "IN_PROGRESS"
            raise GraphQL::ExecutionError, "Support request is not open for comments"
          end
        end

        if user.role == "AGENT" && support_request.agent_id.present?
          raise GraphQL::ExecutionError, "This support request has been assigned"
        end

        
        comment = ::Comment.new(
          text: text,
          support_request_id: support_request_id,
          user_id: user.id,
        )
  
        ActiveRecord::Base.transaction do
          begin
            comment.save!
            support_request.update!(status: "IN_PROGRESS", agent_id: user.id)
            { comment: comment }
          rescue => e
            raise GraphQL::ExecutionError, e.message
          end
        end

        { comment: comment.reload }
      end
    end
  end 