require "./musiki/models/metadata"

class Band < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :description
  attr_writer :origin
  attr_writer :country
  attr_writer :active
  attr_writer :genres
  attr_writer :images
  attr_writer :main_youtube
  attr_writer :apple
  attr_writer :play
  attr_writer :spotify
  attr_writer :soundcloud
  attr_writer :bandcamp
  attr_writer :youtube
  attr_writer :website
  attr_writer :wikipedia
  attr_writer :twitter
  attr_writer :facebook
  attr_writer :instagram
  attr_writer :links
  attr_writer :members
  attr_writer :past_members
  attr_writer :discs
  attr_writer :body
  attr_writer :public
  attr_writer :memo

  def discs?
    (discs || []).map do |disc|
      Metadata.disc[disc]
    end
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
