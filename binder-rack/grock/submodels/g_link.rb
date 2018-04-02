module GROCK
  class GLink
    LINKS = {
      "apple":        "Apple Music",
      "play":         "Play Music",
      "spotify":      "Spotify",
      "soundcloud":   "SoundCloud",
      "bandcamp":     "BandCamp",
      "youtube":      "YouTube",
      "website":      "Website",
      "wikipedia":    "Wikipedia",
      "twitter":      "Twitter",
      "facebook":     "Facebook",
      "instagram":    "Instagram",
      "discogs": "Discogs",
      "purevolume":   "purevolume",
      "myspace":      "Myspace",
      "amazon":       "Amazon"
    }

    attr_reader :url, :title

    def initialize(data)
      @data = data

      if data.nil?
      elsif data.is_a? Hash
        @url = data["url"]
        @title = data["title"]
      else
        @url = data
      end
    end

    def empty?
      @data.nil?
    end

    def type_name(key)
      text = LINKS[key.to_sym]
      raise "link type is not defined: #{key}" if text.nil?
      text
    end

    def to_s
      @data
    end
  end
end
