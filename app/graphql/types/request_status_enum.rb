module Types
  class RequestStatusEnum < Types::BaseEnum
    value "PENDING", "Request is pending", value: "PENDING"
    value "IN_PROGRESS", "Request is in progress", value: "IN_PROGRESS"
    value "RESOLVED", "Request has been resolved", value: "RESOLVED"
    value "CLOSED", "Request has been closed", value: "CLOSED"
  end
end 