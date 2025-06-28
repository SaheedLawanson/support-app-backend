# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

# Clear existing data to avoid duplicates
puts "Clearing existing data..."
Comment.destroy_all
SupportRequest.destroy_all
User.destroy_all

# Seed function to create users
def create_users
  puts "Creating users..."

  customer = User.create!(
    email: "saheedlawanson47+customer@gmail.com",
    first_name: "Customer",
    last_name: "Lawanson",
    password_hash: BCrypt::Password.create("Password123!"),
    role: "CUSTOMER"
  )
  puts "Created CUSTOMER: #{customer.first_name} #{customer.last_name} (#{customer.email})"

  agent = User.create!(
    email: "saheedlawanson47+agent@gmail.com",
    first_name: "Agent",
    last_name: "Lawanson",
    password_hash: BCrypt::Password.create("Password123!"),
    role: "AGENT"
  )
  puts "Created AGENT: #{agent.first_name} #{agent.last_name} (#{agent.email})"
  [customer, agent]
end

# Seed function to create support requests
def create_support_requests(customer, agent)
  puts "Creating support requests..."

  # Create various types of support requests with different statuses
  support_requests_data = [
    {
      request_type: "TECHNICAL_SUPPORT",
      subject: "Cannot access my account",
      description: "I'm having trouble logging into my account. I keep getting an error message saying 'Invalid credentials' even though I'm sure my password is correct.",
      status: "PENDING",
      customer: customer,
      agent: nil
    },
    {
      request_type: "BILLING_ISSUE",
      subject: "Incorrect charge on my statement",
      description: "I noticed an unexpected charge of $29.99 on my last billing statement. I don't recognize this charge and would like it to be investigated.",
      status: "IN_PROGRESS",
      customer: customer,
      agent: agent
    },
    {
      request_type: "PRODUCT_ENQUIRY",
      subject: "Information about premium features",
      description: "I'm interested in upgrading to the premium plan. Could you please provide more details about the additional features and pricing?",
      status: "RESOLVED",
      customer: customer,
      agent: agent
    },
    {
      request_type: "TECHNICAL_SUPPORT",
      subject: "App crashes on startup",
      description: "The mobile app crashes immediately when I try to open it. I've tried reinstalling it but the issue persists. I'm using an iPhone 14 with iOS 17.",
      status: "PENDING",
      customer: customer,
      agent: nil
    },
    {
      request_type: "OTHER",
      subject: "Feature request for dark mode",
      description: "I would love to see a dark mode option added to the application. This would be especially helpful for users who work late at night.",
      status: "CLOSED",
      customer: customer,
      agent: agent
    },
    {
      request_type: "BILLING_ISSUE",
      subject: "Refund request for duplicate payment",
      description: "I accidentally made two payments for the same service. I would like to request a refund for the duplicate payment of $49.99.",
      status: "IN_PROGRESS",
      customer: customer,
      agent: agent
    }
  ]

  support_requests = []
  support_requests_data.each_with_index do |data, index|
    support_request = SupportRequest.create!(
      request_type: data[:request_type],
      subject: data[:subject],
      description: data[:description],
      status: data[:status],
      customer: data[:customer],
      agent: data[:agent],
      attachments: []
    )
    puts "Created Support Request #{index + 1}: #{support_request.reference} - #{support_request.subject}"
    support_requests << support_request
  end
  
  support_requests
end

# Seed function to create comments
def create_comments(support_requests, customer, agent)
  puts "Creating comments..."

  comments_data = [
    # Comments for the first support request (TECHNICAL_SUPPORT - PENDING)
    {
      support_request: support_requests[0],
      user: customer,
      text: "I've tried resetting my password multiple times but still can't access my account. Please help!"
    },
    {
      support_request: support_requests[0],
      user: agent,
      text: "I can see your account is locked due to multiple failed login attempts. I've unlocked it for you. Please try logging in again with your original password."
    },
    {
      support_request: support_requests[0],
      user: customer,
      text: "Thank you! I was able to log in successfully now."
    },

    # Comments for the second support request (BILLING_ISSUE - IN_PROGRESS)
    {
      support_request: support_requests[1],
      user: customer,
      text: "The charge appeared on my statement dated March 15th. It shows as 'Premium Service' but I never signed up for this."
    },
    {
      support_request: support_requests[1],
      user: agent,
      text: "I can see the charge in our system. It appears to be an automatic renewal of a premium subscription. Let me investigate this further and get back to you within 24 hours."
    },
    {
      support_request: support_requests[1],
      user: agent,
      text: "I've reviewed your account history. It looks like you had a free trial that automatically converted to a paid subscription. I've processed a refund for the $29.99 charge."
    },

    # Comments for the third support request (PRODUCT_ENQUIRY - RESOLVED)
    {
      support_request: support_requests[2],
      user: customer,
      text: "I'm currently on the basic plan and would like to know what additional features come with the premium upgrade."
    },
    {
      support_request: support_requests[2],
      user: agent,
      text: "Great question! The premium plan includes: advanced analytics, priority support, unlimited storage, and custom integrations. The cost is $19.99/month or $199/year (saving 17%). Would you like me to send you a detailed comparison?"
    },
    {
      support_request: support_requests[2],
      user: customer,
      text: "That sounds perfect! I'd like to upgrade to the annual plan. Can you help me with that?"
    },
    {
      support_request: support_requests[2],
      user: agent,
      text: "Absolutely! I've upgraded your account to the premium annual plan. You'll be charged $199 today, and your next billing date will be in 12 months. You now have access to all premium features!"
    },

    # Comments for the fourth support request (TECHNICAL_SUPPORT - PENDING)
    {
      support_request: support_requests[3],
      user: customer,
      text: "The app worked fine until the last update. Now it crashes every time I open it."
    },
    {
      support_request: support_requests[3],
      user: agent,
      text: "I'm sorry to hear about this issue. Can you please try clearing the app cache and data, then reinstall the app? Also, please let me know what version of the app you're currently using."
    },

    # Comments for the fifth support request (Other - CLOSED)
    {
      support_request: support_requests[4],
      user: customer,
      text: "Dark mode would be a great addition to the app. Many users would appreciate this feature."
    },
    {
      support_request: support_requests[4],
      user: agent,
      text: "Thank you for the suggestion! Dark mode is actually already in development and should be available in our next major update (version 3.0) scheduled for next month. I'll mark this request as closed since it's already being addressed."
    },

    # Comments for the sixth support request (BILLING_ISSUE - IN_PROGRESS)
    {
      support_request: support_requests[5],
      user: customer,
      text: "I made a payment on March 10th, but then accidentally made another payment on March 11th. Both were for $49.99. I only need one payment."
    },
    {
      support_request: support_requests[5],
      user: agent,
      text: "I can see both payments in our system. I've initiated a refund for the duplicate payment made on March 11th. The refund should appear in your account within 3-5 business days."
    },
    {
      support_request: support_requests[5],
      user: customer,
      text: "Perfect, thank you for the quick response!"
    }
  ]

  comments_data.each_with_index do |data, index|
    comment = Comment.create!(
      user: data[:user],
      support_request: data[:support_request],
      text: data[:text]
    )
    puts "Created Comment #{index + 1}: #{comment.user.first_name} on #{comment.support_request.reference}"
  end
end

# Run the seed functions
users = create_users
support_requests = create_support_requests(users[0], users[1])
create_comments(support_requests, users[0], users[1])

puts "Seeding completed successfully!"
