require "./musiki/models/metadata"

class Song < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :band
  attr_writer :disc
  attr_writer :youtube
  attr_writer :guests
  attr_writer :body
  attr_writer :public
  attr_writer :memo
end
