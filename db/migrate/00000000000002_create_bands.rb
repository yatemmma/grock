class CreateBands < ActiveRecord::Migration[5.2]
  def change
    create_table :bands, id: false do |t|
        t.string :code, null: false
        t.string :name
        t.string :description
        t.string :active
        t.string :origin
        t.string :images
        t.string :videos
        t.string :genres
        t.string :apple
        t.string :play
        t.string :spotify
        t.string :soundcloud
        t.string :bandcamp
        t.string :amazon
        t.string :website
        t.string :wikipedia
        t.string :youtube
        t.string :twitter
        t.string :facebook
        t.string :instagram
        t.string :purevolume
        t.string :myspace
        t.string :lastfm
        t.string :discogs
        t.string :links
        t.string :member_of
        t.string :ex_member_of
        t.string :feeds
        t.text   :body
        t.datetime :created_at
        t.datetime :updated_at
    end
    add_index :bands, :code, unique: true
  end
end
