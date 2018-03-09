require "./musiki/models/metadata"

class Band < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :origin
  attr_writer :website
  attr_writer :wikipedia
  attr_writer :twitter
  attr_writer :facebook
  attr_writer :spotify
  attr_writer :apple
  attr_writer :soundcloud
  attr_writer :labelpages
  attr_writer :members
  attr_writer :discs
  attr_writer :body
  attr_writer :memo
end
