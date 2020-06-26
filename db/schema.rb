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

ActiveRecord::Schema.define(version: 2017_03_10_195553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "broadcast_messages", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.string "body", null: false
    t.datetime "last_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "employees", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slack_username", null: false
    t.date "started_on", null: false
    t.string "time_zone", default: "Eastern Time (US & Canada)", null: false
    t.datetime "deleted_at"
    t.string "slack_channel_id"
    t.string "slack_user_id"
    t.index ["deleted_at"], name: "index_employees_on_deleted_at"
    t.index ["slack_user_id"], name: "index_employees_on_slack_user_id"
  end

  create_table "onboarding_messages", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.string "body", null: false
    t.integer "days_after_start", null: false
    t.time "time_of_day", default: "2000-01-01 12:00:00", null: false
    t.date "end_date"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_onboarding_messages_on_deleted_at"
  end

  create_table "quarterly_messages", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", null: false
    t.string "body", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_quarterly_messages_on_deleted_at"
  end

  create_table "sent_messages", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id", null: false
    t.string "error_message", default: "", null: false
    t.text "message_body", null: false
    t.integer "message_id", null: false
    t.date "sent_on", null: false
    t.time "sent_at", default: "2000-01-01 12:00:00", null: false
    t.datetime "deleted_at"
    t.string "message_type", null: false
    t.index ["deleted_at"], name: "index_sent_messages_on_deleted_at"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.boolean "admin", default: false
  end

end
