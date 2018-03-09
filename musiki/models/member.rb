require "./musiki/models/metadata"

class Member < Metadata
  attr_writer :code
  attr_writer :name
  attr_writer :origin
  attr_writer :body
  attr_writer :memo

  def origin
    @metadata[:origin].last
  end

  def country
    @metadata[:origin].first
  end
end
