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

ActiveRecord::Schema.define(version: 2018_04_16_135028) do

  create_table "bands", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "description"
    t.string "image"
    t.string "video"
    t.string "country"
    t.string "origin"
    t.string "active"
    t.string "genres"
    t.string "apple"
    t.string "play"
    t.string "spotify"
    t.string "soundcloud"
    t.string "bandcamp"
    t.string "youtube"
    t.string "website"
    t.string "wikipedia"
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
    t.text "body"
    t.string "feeds"
    t.index ["code"], name: "index_bands_on_code", unique: true
  end

  create_table "discs", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "type"
    t.string "date"
    t.string "bands"
    t.string "labels"
    t.string "genres"
    t.string "video"
    t.string "image"
    t.string "apple"
    t.string "play"
    t.string "spotify"
    t.string "soundcloud"
    t.string "bandcamp"
    t.string "amazon"
    t.string "lastfm"
    t.string "discogs"
    t.string "teaser"
    t.string "playlist"
    t.string "search"
    t.string "links"
    t.string "songs"
    t.string "discs"
    t.string "guests"
    t.text "body"
    t.string "disc_type"
    t.index ["code"], name: "index_discs_on_code", unique: true
  end

  create_table "labels", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "image"
    t.string "video"
    t.string "website"
    t.string "wikipedia"
    t.string "youtube"
    t.string "twitter"
    t.string "facebook"
    t.string "links"
    t.text "body"
    t.string "feeds"
    t.index ["code"], name: "index_labels_on_code", unique: true
  end

end
