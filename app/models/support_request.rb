class SupportRequest < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :agent, class_name: "User", optional: true
  has_many :comments_to_support_request, class_name: 'Comment', foreign_key: 'support_request_id'

  enum :request_type, {
    TECHNICAL_SUPPORT: "TECHNICAL_SUPPORT",
    BILLING_ISSUE: "BILLING_ISSUE",
    PRODUCT_ENQUIRY: "PRODUCT_ENQUIRY",
    OTHER: "OTHER"
  }
  enum :status, {
    PENDING: "PENDING",
    IN_PROGRESS: "IN_PROGRESS",
    RESOLVED: "RESOLVED",
    CLOSED: "CLOSED"
  }

  validates :reference, :request_type, :subject, :description, :status, :customer, presence: true

  validates :request_type, inclusion: { in: request_types.keys, message: "Invalid request type" }
  validates :status, inclusion: { in: statuses.keys, message: "Invalid status" }

  validates :reference, presence: true, uniqueness: true

  before_validation :generate_reference, on: :create

  private

  def generate_reference
    next_id = SupportRequest.maximum(:id).to_i + 1
    self.reference = "#SR-#{next_id.to_s.rjust(4, '0')}"
  end
end
