class CreateDiscs < ActiveRecord::Migration[5.2]
  def change
    create_table :discs, id: false do |t|
        t.string :code, null: false
        t.string :name
        t.string :description
        t.string :date
        t.string :bands
        t.string :labels
        t.string :images
        t.string :videos
        t.string :genres
        t.string :disc_type
        t.string :apple
        t.string :play
        t.string :spotify
        t.string :soundcloud
        t.string :bandcamp
        t.string :amazon
        t.string :wikipedia
        t.string :lastfm
        t.string :discogs
        t.string :teaser
        t.string :playlist
        t.string :search
        t.string :links
        t.string :guests
        t.string :songs
        t.string :discs_of
        t.string :original_videos
        t.string :original_bands
        t.string :original_discs
        t.text   :body
        t.datetime :created_at
        t.datetime :updated_at
    end
    add_index :discs, :code, unique: true
  end
end
