require "./musiki/models/metadata"

class Song < Metadata
  prop :code
  prop :name
  prop :band
  prop :disc
  prop :date
  prop :type
  prop :label
  prop :video_date
  prop :youtube
  prop :apple
  prop :play
  prop :spotify
  prop :links
  prop :guests
  prop :body
  prop :public
  prop :memo

  def id
    "song"
  end

  def title
    name
  end

  def json
    data = {
      name: name,
      band: band,
      note: ""
    }.to_json
  end
end
