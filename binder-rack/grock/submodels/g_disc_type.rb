module GROCK
  class GDiscType
    DISC_TYPES = {
      "album":  "Album",
      "ep":     "EP",
      "single": "Single"
    }

    def initialize(data)
      @data = data
    end

    def name
      if @data.nil?
        nil
      else
        text = DISC_TYPES[@data.to_sym]
        raise "disc type is not defined: #{@data}" if text.nil?
        text
      end
    end

    def short_name
      if @data == "album"
        nil
      else
        name
      end
    end

    def to_s
      @data
    end
  end
end
