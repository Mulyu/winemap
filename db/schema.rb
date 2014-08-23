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

ActiveRecord::Schema.define(version: 20140823014602) do

  create_table "countries", force: true do |t|
    t.string   "name",           limit: 30
    t.integer  "ranking"
    t.string   "svg_id",         limit: 5
    t.integer  "worldregion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "localregions", force: true do |t|
    t.string   "name",       limit: 30
    t.integer  "ranking"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "situations", force: true do |t|
    t.string   "name",       limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "situationswines", id: false, force: true do |t|
    t.integer  "wine_id"
    t.integer  "situation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wines", force: true do |t|
    t.string   "name",           limit: 100,                         null: false
    t.integer  "country_id"
    t.integer  "localregion_id"
    t.decimal  "svg_x",                      precision: 8, scale: 5, null: false
    t.decimal  "svg_y",                      precision: 8, scale: 5, null: false
    t.integer  "body"
    t.integer  "sweetness"
    t.integer  "sourness"
    t.integer  "winetype_id"
    t.integer  "year"
    t.integer  "winevariety_id"
    t.string   "photopath",      limit: 30
    t.integer  "score"
    t.integer  "price"
    t.string   "winery",         limit: 30
    t.integer  "user_id"
    t.float    "winelevel",      limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "winetypes", force: true do |t|
    t.string   "name",       limit: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "winevarieties", force: true do |t|
    t.string   "name",       limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "worldregions", force: true do |t|
    t.string   "name",       limit: 10
    t.decimal  "center_x",              precision: 8, scale: 5
    t.decimal  "center_y",              precision: 8, scale: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
