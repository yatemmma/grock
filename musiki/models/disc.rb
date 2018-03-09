require "./musiki/models/metadata"

class Disc < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :band
  attr_writer :date
  attr_writer :label
  attr_writer :discogs
  attr_writer :spotify
  attr_writer :apple
  attr_writer :songs
  attr_writer :body
  attr_writer :memo
end
