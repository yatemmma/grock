require "./musiki/models/metadata"
require "./musiki/helpers/country_helper"

class Band < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :origin
  attr_writer :country
  attr_writer :active
  attr_writer :website
  attr_writer :wikipedia
  attr_writer :twitter
  attr_writer :facebook
  attr_writer :youtube
  attr_writer :instagram
  attr_writer :spotify
  attr_writer :apple
  attr_writer :soundcloud
  attr_writer :bandcamp
  attr_writer :labelpages
  attr_writer :links
  attr_writer :members
  attr_writer :past_members
  attr_writer :discs
  attr_writer :body
  attr_writer :public
  attr_writer :memo

  include CountryHelper
end
