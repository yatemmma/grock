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

  create_table "feed_urls", id: false, force: :cascade do |t|
    t.string "url"
    t.boolean "enabled", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["url"], name: "index_feed_urls_on_url", unique: true
  end

  create_table "raw_feeds", force: :cascade do |t|
    t.string "url"
    t.text "source"
    t.boolean "parsed", default: false
    t.text "error"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
