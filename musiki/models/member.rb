require "./musiki/models/metadata"

class Member < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :description
  attr_writer :origin
  attr_writer :country
  attr_writer :main_youtube
  attr_writer :images
  attr_writer :links
  attr_writer :bands
  attr_writer :songs
  attr_writer :body
  attr_writer :public
  attr_writer :memo

  def json
    data = {
      name: name,
      country: country_name,
      note: ""
    }.to_json
  end
end
