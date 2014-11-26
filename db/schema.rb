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

ActiveRecord::Schema.define(version: 20141126134709) do

  create_table "finders", force: true do |t|
    t.boolean  "available"
    t.string   "site_name"
    t.string   "country_classification"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "site_url"
  end

  create_table "found_posts", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.date     "released_date"
    t.string   "source"
    t.integer  "finder_id"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_author"
  end

  create_table "libraries", force: true do |t|
    t.string   "translated_name"
    t.string   "country_classification"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_name"
  end

  create_table "librarizations", force: true do |t|
    t.integer  "user_id"
    t.integer  "library_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "librirarizations", force: true do |t|
    t.integer  "user_id"
    t.integer  "library_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "country_classification"
    t.boolean  "publish",                default: false
    t.text     "note",                   default: ""
    t.string   "image"
    t.datetime "source_date"
    t.datetime "publish_date"
    t.string   "classification"
    t.string   "original_author"
    t.boolean  "complete",               default: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "token"
    t.integer  "posts_count",            default: 0
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
    t.integer  "gg_point",               default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
