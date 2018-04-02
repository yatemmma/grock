module GROCK
  class GGuest
    attr_reader :code, :label

    def initialize(data)
      @data = data
      @code = data["code"]
      @label = data["label"]
    end

    def to_s
      @data
    end
  end
end
