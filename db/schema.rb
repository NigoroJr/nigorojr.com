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

ActiveRecord::Schema.define(version: 20140725142002) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "posted_by"
    t.string   "category"
    t.string   "tags"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "article_id", null: false
    t.string   "name",       null: false
    t.text     "body",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "photos", force: true do |t|
    t.string   "location"
    t.string   "object"
    t.string   "category"
    t.string   "file_path"
    t.string   "posted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "website"
    t.string   "category"
    t.string   "team"
    t.date     "updated"
    t.string   "version"
    t.string   "posted_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "screen"
    t.string   "username",        null: false
    t.string   "hashed_password", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
