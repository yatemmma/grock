require "./musiki/models/metadata"
require "./musiki/helpers/country_helper"

class Member < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :origin
  attr_writer :country
  attr_writer :body
  attr_writer :public
  attr_writer :memo

  include CountryHelper
end
