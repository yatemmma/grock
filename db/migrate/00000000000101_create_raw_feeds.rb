class CreateRawFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :raw_feeds do |t|
        t.string   :url
        t.text     :source
        t.boolean  :parsed, default: false
        t.text     :error
        t.datetime :created_at
        t.datetime :updated_at
    end
  end
end
