module Types
  class RequestTypeEnum < Types::BaseEnum
    value "TECHNICAL_SUPPORT", "Technical support request", value: "TECHNICAL_SUPPORT"
    value "BILLING_ISSUE", "Billing issue request", value: "BILLING_ISSUE"
    value "PRODUCT_ENQUIRY", "Product enquiry request", value: "PRODUCT_ENQUIRY"
    value "OTHER", "Other type of request", value: "OTHER"
  end
end 