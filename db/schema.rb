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

ActiveRecord::Schema.define(version: 20140829024246) do

  create_table "countries", force: true do |t|
    t.string  "name",           limit: 30,                         null: false
    t.integer "ranking",                                           null: false
    t.string  "svg_id",         limit: 5,                          null: false
    t.decimal "center_x",                  precision: 8, scale: 5, null: false
    t.decimal "center_y",                  precision: 8, scale: 5, null: false
    t.integer "worldregion_id",                                    null: false
  end

  create_table "localregions", force: true do |t|
    t.string  "name",       limit: 30
    t.integer "ranking"
    t.integer "country_id"
  end

  create_table "prefectures", force: true do |t|
    t.string "name", limit: 5, null: false
  end

  create_table "situations", force: true do |t|
    t.string "name", limit: 30, null: false
  end

  create_table "situations_wines", id: false, force: true do |t|
    t.integer "wine_id",      null: false
    t.integer "situation_id", null: false
  end

  create_table "users", force: true do |t|
    t.string   "name",               limit: 15,  null: false
    t.string   "email",                          null: false
    t.string   "password",           limit: 127, null: false
    t.integer  "age"
    t.integer  "gender"
    t.string   "job",                limit: 30
    t.boolean  "married"
    t.string   "introduction"
    t.float    "winelevel",          limit: 24,  null: false
    t.integer  "winenum",                        null: false
    t.integer  "follow",                         null: false
    t.integer  "follower",                       null: false
    t.integer  "ranking",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prefecture_id",                  null: false
    t.integer  "home_prefecture_id",             null: false
  end

  create_table "users_users", id: false, force: true do |t|
    t.integer "from_user_id", null: false
    t.integer "to_user_id",   null: false
  end

  create_table "wines", force: true do |t|
    t.string   "name",           limit: 100,                         null: false
    t.integer  "localregion_id",                                     null: false
    t.decimal  "svg_latitude",               precision: 8, scale: 5, null: false
    t.decimal  "svg_longitude",              precision: 8, scale: 5, null: false
    t.integer  "body"
    t.integer  "sweetness"
    t.integer  "sourness"
    t.integer  "year"
    t.string   "photopath",      limit: 30
    t.integer  "score"
    t.integer  "price"
    t.string   "winery",         limit: 30
    t.float    "winelevel",      limit: 24,                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id",                                         null: false
    t.integer  "winetype_id",                                        null: false
    t.integer  "user_id",                                            null: false
  end

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
