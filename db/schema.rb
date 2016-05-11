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

ActiveRecord::Schema.define(version: 20160510153209) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "journeys", force: :cascade do |t|
    t.integer  "quest_id"
    t.integer  "user_id"
    t.boolean  "current"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "journeys", ["quest_id"], name: "index_journeys_on_quest_id", using: :btree
  add_index "journeys", ["user_id"], name: "index_journeys_on_user_id", using: :btree

  create_table "quests", force: :cascade do |t|
    t.string   "grail"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer  "survey"
    t.integer  "journey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image_id"
  end

  add_index "reports", ["journey_id"], name: "index_reports_on_journey_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cellphone"
    t.string   "contact_pref"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "authy_id"
    t.string   "country_code"
  end

  add_foreign_key "journeys", "quests"
  add_foreign_key "journeys", "users"
  add_foreign_key "reports", "journeys"
end
