class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds, id: false do |t|
      t.string   :kind, null: false
      t.string   :code, null: false
      t.string   :type
      t.string   :icon
      t.string   :url
      t.datetime :date
      t.string   :title
      t.text     :body
      t.string   :youtube_keys
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :feeds, [:kind, :code], name: "feeds_index"
  end
end
