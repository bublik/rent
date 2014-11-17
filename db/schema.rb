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

ActiveRecord::Schema.define(version: 20141117165033) do

  create_table "accesses", force: true do |t|
    t.integer  "user_id"
    t.integer  "renter_id"
    t.integer  "counter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accesses", ["renter_id"], name: "index_accesses_on_renter_id", using: :btree
  add_index "accesses", ["user_id"], name: "index_accesses_on_user_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "renter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "skip_payment", default: false, null: false
  end

  add_index "orders", ["renter_id"], name: "index_orders_on_renter_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "renters", force: true do |t|
    t.string   "phone"
    t.string   "email"
    t.datetime "guard_time"
    t.string   "town"
    t.integer  "rooms"
    t.integer  "amount"
    t.datetime "check_in"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",      default: 1,       null: false
    t.integer  "orders_count", default: 0,       null: false
    t.datetime "check_out"
    t.integer  "amount_grn"
    t.string   "state"
    t.datetime "published_at"
    t.integer  "people"
    t.boolean  "has_emailed",  default: false,   null: false
    t.string   "phone_format", default: "timer"
    t.integer  "town_id"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "settings", force: true do |t|
    t.boolean  "autoopen"
    t.string   "autoopen_interval"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "users",             default: "--- []\n"
    t.integer  "guard_time",        default: 120
  end

  create_table "towns", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "phone"
    t.string   "description"
    t.integer  "orders_count",           default: 0,    null: false
    t.integer  "renters_count",          default: 0,    null: false
    t.integer  "free_orders",            default: 0,    null: false
    t.boolean  "subscribe",              default: true, null: false
    t.string   "auth_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
