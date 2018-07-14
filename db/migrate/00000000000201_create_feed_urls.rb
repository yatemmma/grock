class CreateFeedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :feed_urls, id: false do |t|
      t.string   :url
      t.boolean  :enabled, default: true
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :feed_urls, :url, unique: true
  end
end
