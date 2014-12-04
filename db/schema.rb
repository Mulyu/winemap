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

ActiveRecord::Schema.define(version: 20141204151644) do

  create_table "countries", force: true do |t|
    t.string  "name",           limit: 30,                         null: false
    t.integer "ranking",                                           null: false
    t.string  "svg_id",         limit: 5,                          null: false
    t.decimal "center_x",                  precision: 8, scale: 5, null: false
    t.decimal "center_y",                  precision: 8, scale: 5, null: false
    t.integer "worldregion_id",                                    null: false
  end

  create_table "countrycodes", id: false, force: true do |t|
    t.integer "code",       null: false
    t.integer "country_id", null: false
  end

  add_index "countrycodes", ["country_id"], name: "index_countrycodes_on_country_id", using: :btree

  create_table "follows", id: false, force: true do |t|
    t.integer "from_user_id", null: false
    t.integer "to_user_id",   null: false
  end

  create_table "localregions", force: true do |t|
    t.string  "name",       limit: 100, null: false
    t.integer "ranking",                null: false
    t.integer "country_id",             null: false
  end

  create_table "logininfos", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobile_token",           limit: 16
  end

  add_index "logininfos", ["email"], name: "index_logininfos_on_email", unique: true, using: :btree
  add_index "logininfos", ["reset_password_token"], name: "index_logininfos_on_reset_password_token", unique: true, using: :btree

  create_table "prefectureregions", force: true do |t|
    t.string "name", limit: 6, null: false
  end

  create_table "prefectures", force: true do |t|
    t.string  "name",                limit: 5, null: false
    t.integer "prefectureregion_id",           null: false
  end

  create_table "situations", force: true do |t|
    t.string "name", limit: 30, null: false
  end

  create_table "situations_wines", id: false, force: true do |t|
    t.integer "wine_id",      null: false
    t.integer "situation_id", null: false
  end

  create_table "users", force: true do |t|
    t.string   "name",               limit: 15,             null: false
    t.integer  "gender"
    t.string   "job",                limit: 30
    t.integer  "married",                       default: 0
    t.string   "introduction"
    t.float    "winelevel",          limit: 24,             null: false
    t.integer  "follow",                                    null: false
    t.integer  "follower",                                  null: false
    t.integer  "ranking",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prefecture_id"
    t.integer  "home_prefecture_id"
    t.date     "birth"
    t.integer  "logininfo_id",                              null: false
  end

  create_table "wines", force: true do |t|
    t.string   "name",           limit: 100,                         null: false
    t.decimal  "latitude",                   precision: 8, scale: 5, null: false
    t.decimal  "longitude",                  precision: 8, scale: 5, null: false
    t.integer  "body"
    t.integer  "sweetness"
    t.integer  "sourness"
    t.integer  "year"
    t.integer  "score"
    t.integer  "price"
    t.string   "winery",         limit: 100
    t.float    "winelevel",      limit: 24,                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id",                                         null: false
    t.integer  "winetype_id",                                        null: false
    t.integer  "user_id",                                            null: false
    t.string   "input_region",   limit: 30,                          null: false
    t.integer  "localregion_id",                                     null: false
    t.string   "photo"
  end

  add_index "wines", ["localregion_id"], name: "index_wines_on_localregion_id", using: :btree

  create_table "wines_winevarieties", id: false, force: true do |t|
    t.integer "wine_id",        null: false
    t.integer "winevariety_id", null: false
  end

  create_table "winetypes", force: true do |t|
    t.string "name", limit: 10
  end

  create_table "winevarieties", force: true do |t|
    t.string "name", limit: 30, null: false
  end

  create_table "worldregions", force: true do |t|
    t.string "name", limit: 10, null: false
  end

end
