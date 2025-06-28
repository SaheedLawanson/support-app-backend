class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :support_request

  validates :text, :support_request, :user, presence: true
end
