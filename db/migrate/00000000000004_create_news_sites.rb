class CreateNewsSites < ActiveRecord::Migration[5.2]
  def change
    create_table :news_sites, id: false do |t|
      t.string   :code, null: false
      t.string   :name
      t.string   :description
      t.string   :image_icon
      t.string   :image_thumbnail
      t.string   :image_large
      t.string   :site_url
      t.string   :feed_url
      t.string   :genres
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :news_sites, :code, unique: true
  end
end
