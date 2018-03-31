require "./musiki/models/metadata"

class Band < Metadata
  prop :code
  prop :name
  prop :description
  prop :origin
  prop :country
  prop :active
  prop :genres
  prop :images
  prop :main_youtube
  prop :apple
  prop :play
  prop :spotify
  prop :soundcloud
  prop :bandcamp
  prop :youtube
  prop :website
  prop :wikipedia
  prop :twitter
  prop :facebook
  prop :instagram
  prop :purevolume
  prop :myspace
  prop :discogs
  prop :links
  prop :members
  prop :past_members
  prop :discs
  prop :videos
  prop :body
  prop :public
  prop :memo

  def id
    "band"
  end

  def title
    name
  end

  def json
    data = {
      name: name,
      country: country_name,
      active: active_short,
      genre: main_genre,
      note: ""
    }.to_json
  end
end
