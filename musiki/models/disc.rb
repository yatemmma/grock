require "./musiki/models/metadata"

class Disc < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :band
  attr_writer :type
  attr_writer :date
  attr_writer :label
  attr_writer :images
  attr_writer :main_youtube
  attr_writer :apple
  attr_writer :play
  attr_writer :spotify
  attr_writer :amazon
  attr_writer :discogs
  attr_writer :youtube
  attr_writer :links
  attr_writer :songs
  attr_writer :guests
  attr_writer :body
  attr_writer :public
  attr_writer :memo

  def id
    "disc"
  end

  def title
    name
  end

  def json
    data = {
      name: name,
      band: band,
      date: date,
      type: type,
      note: ""
    }.to_json
  end
end
