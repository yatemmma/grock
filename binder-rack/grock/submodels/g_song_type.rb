module GROCK
  class GSongType
    SONG_TYPES = {
      "music_video": "Music Video",
      "guest":       "Special Guest",
      "acoustic":    "Acoustic"
    }

    def initialize(data)
      @data = data
    end

    def name
      if @data.nil?
        nil
      else
        text = SONG_TYPES[@data.to_sym]
        raise "song type is not defined: #{@data}" if text.nil?
        text
      end
    end

    def to_s
      @data
    end
  end
end
