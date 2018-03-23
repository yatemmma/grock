require "./musiki/models/metadata"

class Label < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :website
  attr_writer :wikipedia
  attr_writer :youtube
  attr_writer :links
  attr_writer :images
  attr_writer :body
  attr_writer :public
  attr_writer :memo

  def json
    data = {
      name: name,
      note: ""
    }.to_json
  end
end
