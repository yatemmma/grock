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

  create_table "bands", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "description"
    t.string "active"
    t.string "origin"
    t.string "images"
    t.string "videos"
    t.string "genres"
    t.string "apple"
    t.string "play"
    t.string "spotify"
    t.string "soundcloud"
    t.string "bandcamp"
    t.string "amazon"
    t.string "website"
    t.string "wikipedia"
    t.string "youtube"
    t.string "twitter"
    t.string "facebook"
    t.string "instagram"
    t.string "purevolume"
    t.string "myspace"
    t.string "lastfm"
    t.string "discogs"
    t.string "links"
    t.string "member_of"
    t.string "ex_member_of"
    t.string "feeds"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_bands_on_code", unique: true
  end

  create_table "discs", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "description"
    t.string "date"
    t.string "bands"
    t.string "labels"
    t.string "images"
    t.string "videos"
    t.string "genres"
    t.string "disc_type"
    t.string "apple"
    t.string "play"
    t.string "spotify"
    t.string "soundcloud"
    t.string "bandcamp"
    t.string "amazon"
    t.string "wikipedia"
    t.string "lastfm"
    t.string "discogs"
    t.string "teaser"
    t.string "playlist"
    t.string "search"
    t.string "links"
    t.string "guests"
    t.string "songs"
    t.string "discs_of"
    t.string "original_videos"
    t.string "original_bands"
    t.string "original_discs"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_discs_on_code", unique: true
  end

  create_table "feeds", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "owner"
    t.string "owner_name"
    t.string "feed_type"
    t.string "icon"
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
    t.string "feeds"
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
