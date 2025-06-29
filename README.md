# Support Backend

A Ruby on Rails GraphQL API for managing support requests and customer interactions with authentication, role-based access control, and real-time ticket management.

## Technology Stack
- **Backend**: Ruby on Rails 8.0 with GraphQL
- **Database**: PostgreSQL with ActiveRecord ORM
- **Authentication**: JWT-based token authentication
- **Containerization**: Docker with multi-stage builds
- **Deployment**: Docker Compose for development

## Core Features
- **User Management**: Customer and agent roles with different permissions
- **Support Request System**: Create, update, and track support tickets
- **Comment System**: Real-time communication between customers and agents
- **Status Tracking**: PENDING, IN_PROGRESS, RESOLVED, CLOSED
- **Request Types**: TECHNICAL_SUPPORT, BILLING_ISSUE, PRODUCT_ENQUIRY, OTHER

## Application Structure

### GraphQL Schema
- **Query Types**: Support request retrieval, user management, data filtering
- **Mutation Types**: Authentication, support request creation, status updates
- **Custom Resolvers**: Optimized data fetching with pagination
- **Type Safety**: Strong typing with custom enums and validation

### Database Design
- **Users Table**: Customer and agent accounts with role-based access
- **Support Requests Table**: Main ticket system with references and status tracking
- **Comments Table**: Communication system linking users to support requests
- **Relationships**: Foreign key constraints and referential integrity

### Authentication System
- **JWT Implementation**: Secure token-based authentication using Rails credentials
- **Role-Based Access**: Different permissions for customers vs agents
- **Token Expiration**: Configurable token lifetime with automatic expiration

## Development Setup

### Prerequisites
- Docker and Docker Compose
- Git

### Quick Start
1. Clone repository and navigate to project directory
2. Create `.env` file with database credentials shown in `.env.example` and `RAILS_MASTER_KEY`
3. Add JWT secret to Rails credentials: `rails credentials:edit`
4. Run `docker-compose up --build`
5. Access GraphQL endpoint at `http://localhost:3000/graphql`

### Docker Architecture
- **Multi-Stage Build**: Optimized production image
- **PostgreSQL Container**: Database service with persistent storage
- **Rails Application**: Web service with live code reloading
- **Health Checks**: Automated service monitoring

## API Endpoints
- **GraphQL**: `/graphql` - Main API interface with schema introspection
- **Key Operations**: Authentication, support requests CRUD, comments, user management

## Test Credentials
The application comes with pre-seeded test accounts:

### Customer Account
- **Email**: `saheedlawanson47+customer@gmail.com`
- **Password**: `Password123!`

### Agent Accounts
- **Email**: `saheedlawanson47+agent@gmail.com`
- **Password**: `Password123!`

- **Email**: `saheedlawanson47+agent2@gmail.com`
- **Password**: `Password123!`

Use these credentials to test the GraphQL authentication and role-based features.

## Security Features
- **JWT Tokens**: Secure stateless authentication
- **Role-Based Access**: Customer vs agent permission levels
- **Input Validation**: GraphQL argument validation and type checking
- **Encrypted Credentials**: Sensitive data stored in Rails encrypted credentials

## Missing Features & Future Implementation

### Required Features Not Yet Implemented
- **CSV Export**: Export functionality for closed tickets in the last month
- **Email Reminders**: Daily email notifications for open tickets
- **Update Ticket Status**: Updating a ticket to closed or completed