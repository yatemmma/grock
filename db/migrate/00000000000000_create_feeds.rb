class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds, id: false do |t|
        t.string   :code, null: false
        t.string   :owner
        t.string   :owner_name
        t.string   :feed_type
        t.string   :icon
        t.string   :url
        t.datetime :date
        t.string   :title
        t.text     :body
        t.datetime :created_at
        t.datetime :updated_at
    end
    add_index :feeds, :code, unique: true
  end
end
