require "./musiki/models/metadata"

class Label < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :website
  attr_writer :wikipedia
  attr_writer :body
  attr_writer :memo
end
