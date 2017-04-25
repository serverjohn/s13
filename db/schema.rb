# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161203222156) do

  create_table "checkouts", force: true do |t|
    t.integer  "user_id"
    t.integer  "territory_id"
    t.integer  "publisher_id"
    t.integer  "territory_type_id"
    t.integer  "worked_with_type_id"
    t.datetime "checked_out"
    t.datetime "checked_in"
    t.string   "completed_with"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "checkin_user_id"
  end

  create_table "checkouts_publishers", id: false, force: true do |t|
    t.integer  "checkout_id"
    t.integer  "publisher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publishers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.string   "textmessage"
    t.string   "active"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "territories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "maps"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "active"
    t.string   "territory_type_id"
  end

  create_table "territory_types", force: true do |t|
    t.string "name"
    t.string "active"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "worked_with_types", force: true do |t|
    t.string "name",   null: false
    t.string "active", null: false
  end

end
