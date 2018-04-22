class CreateDiscs < ActiveRecord::Migration[5.2]
  def change
    create_table :discs, id: false do |t|
        t.string :code, null: false
        t.string :name
        t.string :type
        t.string :date
        t.string :bands
        t.string :labels
        t.string :genres
        t.string :video
        t.string :image
        t.string :apple
        t.string :play
        t.string :spotify
        t.string :soundcloud
        t.string :bandcamp
        t.string :amazon
        t.string :lastfm
        t.string :discogs
        t.string :teaser
        t.string :playlist
        t.string :search
        t.string :links
        t.string :songs
        t.string :discs
        t.string :guests
        t.text   :body
    end
    add_index :discs, :code, unique: true
  end
end
