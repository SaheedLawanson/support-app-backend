# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_28_062513) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "support_request_id", null: false
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["support_request_id"], name: "index_comments_on_support_request_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "support_requests", force: :cascade do |t|
    t.string "reference"
    t.string "request_type"
    t.string "subject"
    t.text "description"
    t.string "attachments", default: [], array: true
    t.string "status"
    t.bigint "customer_id", null: false
    t.bigint "agent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_support_requests_on_agent_id"
    t.index ["customer_id"], name: "index_support_requests_on_customer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "password_hash"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
  end

  add_foreign_key "comments", "support_requests"
  add_foreign_key "comments", "users"
  add_foreign_key "support_requests", "users", column: "agent_id"
  add_foreign_key "support_requests", "users", column: "customer_id"
end
