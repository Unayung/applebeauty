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

ActiveRecord::Schema.define(version: 20160325071049) do

  create_table "links", force: :cascade do |t|
    t.string   "url",        limit: 255
    t.string   "title",      limit: 255
    t.integer  "rate",       limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.string   "clip",       limit: 255
    t.text     "detail",     limit: 65535
    t.boolean  "appeal",                   default: false
    t.string   "link_type",  limit: 255,   default: "daily"
  end

  add_index "links", ["link_type"], name: "index_links_on_link_type", using: :btree
  add_index "links", ["title"], name: "index_links_on_title", using: :btree
  add_index "links", ["url"], name: "index_links_on_url", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "file",                   limit: 255
    t.integer  "link_id",                limit: 4
    t.string   "file_width",             limit: 255
    t.string   "file_height",            limit: 255
    t.string   "file_image_size",        limit: 255
    t.string   "file_content_type",      limit: 255
    t.string   "file_tiny_width",        limit: 255
    t.string   "file_tiny_height",       limit: 255
    t.string   "file_tiny_image_size",   limit: 255
    t.string   "file_tiny_content_type", limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "ip",         limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id",   limit: 4
    t.string   "votable_type", limit: 255
    t.integer  "voter_id",     limit: 4
    t.string   "voter_type",   limit: 255
    t.boolean  "vote_flag"
    t.string   "vote_scope",   limit: 255
    t.integer  "vote_weight",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
