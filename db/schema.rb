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

ActiveRecord::Schema.define(version: 20160425203751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category", null: false
  end

  add_index "categories", ["category"], name: "index_categories_on_category", using: :btree

  create_table "hours", force: :cascade do |t|
    t.string  "mon",      null: false
    t.string  "tues",     null: false
    t.string  "wed",      null: false
    t.string  "thurs",    null: false
    t.string  "fri",      null: false
    t.string  "sat",      null: false
    t.string  "sun",      null: false
    t.integer "place_id", null: false
  end

  add_index "hours", ["place_id"], name: "index_hours_on_place_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.string  "url",      null: false
    t.integer "place_id"
  end

  add_index "photos", ["url"], name: "index_photos_on_url", using: :btree

  create_table "place_categories", force: :cascade do |t|
    t.integer  "category_id", null: false
    t.integer  "place_id",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "place_categories", ["category_id"], name: "index_place_categories_on_category_id", using: :btree
  add_index "place_categories", ["place_id"], name: "index_place_categories_on_place_id", using: :btree

  create_table "places", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "address",    null: false
    t.string   "phone"
    t.string   "website"
    t.boolean  "favorite",   null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "places", ["favorite"], name: "index_places_on_favorite", using: :btree
  add_index "places", ["name"], name: "index_places_on_name", using: :btree
  add_index "places", ["user_id"], name: "index_places_on_user_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.string  "name"
    t.string  "content"
    t.integer "rating"
    t.integer "place_id", null: false
  end

  add_index "reviews", ["place_id"], name: "index_reviews_on_place_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name", null: false
    t.string   "last_name",  null: false
    t.string   "username",   null: false
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
