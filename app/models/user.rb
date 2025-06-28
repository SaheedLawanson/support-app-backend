require "bcrypt"


class User < ApplicationRecord
    include BCrypt

    has_many :support_requests_as_customer, class_name: 'SupportRequest', foreign_key: 'customer_id'
    has_many :support_requests_as_agent, class_name: 'SupportRequest', foreign_key: 'agent_id'
    has_many :comments_as_user, class_name: 'Comment', foreign_key: 'user_id'

    # Define role enum
    enum :role, {
        AGENT: "AGENT", 
        CUSTOMER: "CUSTOMER"
    }

    PASSWORD_REGEXP = /\A
        (?=.{8,}) # Minimum 8 characters
        (?=.*\d) # At least one digit
        (?=.*[a-z]) # At least one lowercase letter
        (?=.*[A-Z]) # At least one uppercase letter
        (?=.*[[:^alnum:]]) # At least one special character
    /x

    # Password hash getter
    def password
        @password ||= Password.new(password_hash)
    end

    # Password hash setter
    def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
    end

    validates :role, presence: true, inclusion: { in: roles.keys }
    validates :email, uniqueness: true, presence: true
    validate :validate_password_format, if: -> { @password.present? }

    before_save { self.email = email.downcase }

    private

    def validate_password_format
        unless @password.match(PASSWORD_REGEXP)
          errors.add(
            :password, 
            [
                "Password must be at least 8 characters long", 
                "contain at least one uppercase letter", 
                "one lowercase letter", 
                "one number, and one special character"
            ]
          )
        end
    end 
end
