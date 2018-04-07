module GROCK
  class GGenre
    GENRES = {
      "acoustic":      "Acoustic",
      "blues_rock":    "Blues Rock",
      "electronicore": "Electronicore",
      "techno_rock":   "Techno Rock",
      "christian_hardcore": "Christian Hardcore",
      "indie_rock":    "Indie Rock",
      "indie_pop":     "Indie Pop",
      "post-hardcore": "Post-Hardcore",
      "metalcore":     "Metalcore",
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
