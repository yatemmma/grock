class CreateRawFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :raw_feeds, id: true do |t|
        t.string   :url
        t.string   :source
        t.bool     :parsed
        t.datetime :created_at
        t.datetime :updated_at
    end
  end
end
