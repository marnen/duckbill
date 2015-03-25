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

ActiveRecord::Schema.define(version: 20150324034939) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.integer  "user_id",              null: false
    t.string   "name"
    t.string   "company"
    t.string   "email"
    t.string   "street"
    t.string   "city"
    t.string   "state",      limit: 2
    t.string   "zip"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "project_id",         null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "client_version_id",  null: false
    t.integer  "project_version_id", null: false
    t.integer  "user_version_id",    null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "client_id",  null: false
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_entries", force: :cascade do |t|
    t.date     "date",                                null: false
    t.decimal  "hours",       precision: 4, scale: 2, null: false
    t.string   "description",                         null: false
    t.text     "notes"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "project_id",                          null: false
    t.integer  "invoice_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "",                           null: false
    t.string   "encrypted_password",               default: "",                           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,                            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.string   "name"
    t.string   "company"
    t.string   "street"
    t.string   "city"
    t.string   "state",                  limit: 2
    t.string   "zip"
    t.string   "time_zone",                        default: "Eastern Time (US & Canada)", null: false
    t.string   "date_format",                      default: "db",                         null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  add_foreign_key "clients", "users"
  add_foreign_key "invoices", "projects"
  add_foreign_key "invoices", "versions", column: "client_version_id"
  add_foreign_key "invoices", "versions", column: "project_version_id"
  add_foreign_key "invoices", "versions", column: "user_version_id"
  add_foreign_key "projects", "clients"
  add_foreign_key "time_entries", "invoices"
  add_foreign_key "time_entries", "projects"
end
