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

ActiveRecord::Schema.define(version: 20171106210617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "stop_id"
    t.string "title", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stop_id"], name: "index_comments_on_stop_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "hikers", force: :cascade do |t|
    t.string "name", null: false
    t.float "miles_from_end", null: false
    t.boolean "nobo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stopresources", force: :cascade do |t|
    t.bigint "stop_id"
    t.bigint "resource_id"
    t.float "distance_from_trail"
    t.string "direction_from_trail"
    t.string "stop_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_stopresources_on_resource_id"
    t.index ["stop_id"], name: "index_stopresources_on_stop_id"
  end

  create_table "stops", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.float "miles_from_ga", null: false
    t.integer "elevation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "town_access"
    t.float "miles_from_k", null: false
    t.string "photo_url"
    t.index ["miles_from_ga"], name: "index_stops_on_miles_from_ga", unique: true
    t.index ["miles_from_k"], name: "index_stops_on_miles_from_k", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "stops"
  add_foreign_key "comments", "users"
  add_foreign_key "stopresources", "resources"
  add_foreign_key "stopresources", "stops"
end
