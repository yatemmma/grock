require "./musiki/models/metadata"

class Member < Metadata
  attr_accessor :name, :origin, :body

  def name
    @metadata[:name]
  end

  def origin
    @metadata[:origin].last
  end

  def country
    @metadata[:origin].first
  end

  def body
    @metadata[:body]
  end
end
