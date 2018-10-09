# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_09_023050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendships", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "accepted"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "list_id"
    t.boolean "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_invites_on_list_id"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "list_users", force: :cascade do |t|
    t.bigint "list_id"
    t.bigint "user_id"
    t.boolean "creator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_users_on_list_id"
    t.index ["user_id"], name: "index_list_users_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_users", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "user_id"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "created"
    t.index ["task_id"], name: "index_task_users_on_task_id"
    t.index ["user_id"], name: "index_task_users_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status"
    t.datetime "completed_at"
    t.datetime "due_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "list_id"
    t.integer "lock_version"
    t.index ["list_id"], name: "index_tasks_on_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "email_confirmed"
    t.string "confirm_token"
    t.string "unlock_token"
    t.boolean "account_locked"
    t.integer "login_attempts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_attempt"
  end

  add_foreign_key "friendships", "users"
  add_foreign_key "invites", "lists"
  add_foreign_key "invites", "users"
  add_foreign_key "list_users", "lists"
  add_foreign_key "list_users", "users"
  add_foreign_key "task_users", "tasks"
  add_foreign_key "task_users", "users"
  add_foreign_key "tasks", "lists"
end
