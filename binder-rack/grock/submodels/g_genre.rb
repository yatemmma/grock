module GROCK
  class GGenre
    GENRES = {
      "acoustic":      "Acoustic",
      "indie_rock":    "Indie Rock",
      "post-hardcore": "Post-Hardcore",
      "blues_rock":    "Blues Rock",
      "metalcore":     "Metalcore",
      "christian_metalcore": "Christian metalcore",
      "electronicore": "Electronicore",
      "melodic_rock":  "Melodic Rock"
    }

    def initialize(data)
      @data = data
    end

    def name
      if @data.nil?
        nil
      else
        text = GENRES[@data.to_sym]
        raise "genre is not defined: #{@data}" if text.nil?
        text
      end
    end

    def to_s
      name
    end
  end
end
