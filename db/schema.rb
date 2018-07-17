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

ActiveRecord::Schema.define(version: 201) do

  create_table "bands", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "description"
    t.string "active"
    t.string "origin"
    t.string "youtube_keys"
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
    t.string "disc_type"
    t.string "youtube_keys"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_discs_on_code", unique: true
  end

  create_table "feeds", id: false, force: :cascade do |t|
    t.string "kind", null: false
    t.string "code", null: false
    t.string "name"
    t.string "feed_type"
    t.string "icon"
    t.string "url"
    t.datetime "date"
    t.string "title"
    t.text "body"
    t.string "youtube_keys"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_feeds_on_code", unique: true
  end

  create_table "images", id: false, force: :cascade do |t|
    t.string "kind", null: false
    t.string "code", null: false
    t.string "icon_url"
    t.string "icon_path"
    t.string "thumbnail_url"
    t.string "thumbnail_path"
    t.string "large_url"
    t.string "large_path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index [nil, "code"], name: "images_index"
  end

  create_table "labels", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "description"
    t.string "founded"
    t.string "origin"
    t.string "youtube_keys"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_labels_on_code", unique: true
  end

  create_table "links", id: false, force: :cascade do |t|
    t.string "kind", null: false
    t.string "code", null: false
    t.string "link_type"
    t.string "label"
    t.string "url"
    t.string "title"
    t.boolean "stream", default: false
    t.boolean "purchase", default: false
    t.boolean "feed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index [nil, "code"], name: "links_index"
  end

  create_table "raw_feeds", force: :cascade do |t|
    t.string "model_type"
    t.string "code"
    t.string "url"
    t.string "feed_type"
    t.text "source"
    t.boolean "parsed", default: false
    t.text "error"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["model_type", "code", "parsed"], name: "raw_feeds_index"
  end

  create_table "sites", id: false, force: :cascade do |t|
    t.string "code", null: false
    t.string "name"
    t.string "description"
    t.string "youtube_keys"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_sites_on_code", unique: true
  end

  create_table "tags", id: false, force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "tag_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["code"], name: "index_tags_on_code", unique: true
  end

end
