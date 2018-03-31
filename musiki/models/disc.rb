require "./musiki/models/metadata"

class Disc < Metadata
  prop :code
  prop :name
  prop :band
  prop :type
  prop :date
  prop :label
  prop :images
  prop :main_youtube
  prop :apple
  prop :play
  prop :spotify
  prop :amazon
  prop :discogs
  prop :youtube
  prop :links
  prop :songs
  prop :guests
  prop :body
  prop :public
  prop :memo

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
