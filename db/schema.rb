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

ActiveRecord::Schema.define(version: 20150513020942) do

  create_table "authority_change_requests", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "src_authority",  limit: 4
    t.integer  "dst_authority",  limit: 4
    t.text     "user_remark",    limit: 65535
    t.text     "manager_remark", limit: 65535
    t.string   "status",         limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "authority_change_requests", ["user_id"], name: "index_authority_change_requests_on_user_id", using: :btree

  create_table "password_reset_requests", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.text     "remark",     limit: 65535
    t.string   "status",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "password_reset_requests", ["status"], name: "index_password_reset_requests_on_status", using: :btree
  add_index "password_reset_requests", ["user_id"], name: "index_password_reset_requests_on_user_id", using: :btree

  create_table "user_logs", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "operation",   limit: 255
    t.string   "target_user", limit: 255
    t.text     "remark",      limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "user_logs", ["user_id"], name: "index_user_logs_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "roles_mask",      limit: 4
    t.string   "orgnization",     limit: 255
    t.string   "status",          limit: 255
    t.string   "phonenumber",     limit: 255
  end

  add_index "users", ["status"], name: "index_users_on_status", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "authority_change_requests", "users"
  add_foreign_key "password_reset_requests", "users"
  add_foreign_key "user_logs", "users"
end
