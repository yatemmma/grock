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

ActiveRecord::Schema.define(version: 4) do

  create_table "feeds", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "owner"
    t.string "type"
    t.string "url"
    t.datetime "date"
    t.string "title"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_feeds_on_code", unique: true
  end

  create_table "labels", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "founded"
    t.string "origin"
    t.string "images"
    t.string "videos"
    t.string "website"
    t.string "wikipedia"
    t.string "youtube"
    t.string "twitter"
    t.string "facebook"
    t.string "links"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_labels_on_code", unique: true
  end

  create_table "settings", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.text "json"
    t.index ["code"], name: "index_settings_on_code", unique: true
  end

end
