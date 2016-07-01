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

ActiveRecord::Schema.define(version: 20160630211409) do

  create_table "events", force: :cascade do |t|
    t.string   "name",        default: "", null: false
    t.date     "date",                     null: false
    t.string   "description", default: "", null: false
    t.integer  "user_id",                  null: false
    t.string   "occurance",                null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "reciver_id"
    t.string   "content"
    t.boolean  "deleted_by_sender"
    t.boolean  "deleted_by_reciver"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "messages", ["reciver_id"], name: "index_messages_on_reciver_id"
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id"

  create_table "users", force: :cascade do |t|
    t.datetime "last_seen_messages"
    t.string   "full_name",                           null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
