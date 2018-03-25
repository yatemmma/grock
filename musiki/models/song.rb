require "./musiki/models/metadata"

class Song < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :band
  attr_writer :disc
  attr_writer :date
  attr_writer :type
  attr_writer :label
  attr_writer :video_date
  attr_writer :youtube
  attr_writer :apple
  attr_writer :play
  attr_writer :spotify
  attr_writer :links
  attr_writer :guests
  attr_writer :body
  attr_writer :public
  attr_writer :memo

  def guests?
    (guests || []).map do |guest|
      [Metadata.member[guest["code"]], guest]
    end
  end

  def json
    data = {
      name: name,
      band: band,
      note: ""
    }.to_json
  end
end
