module Types
    class SupportRequestFilterType < Types::BaseInputObject
      argument :customer_id, ID, required: false
      argument :agent_id, ID, required: false
      argument :status, Types::RequestStatusEnum, required: false
      argument :request_type, Types::RequestTypeEnum, required: false
    end
  end