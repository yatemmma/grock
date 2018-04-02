module GROCK
  class GVideo
    def initialize(data)
      @data = data
    end

    def youtube_key
      if @data.nil?
        nil
      else
        uri = URI::parse @data
        query = Hash[URI::decode_www_form(uri.query)]
        query["v"]
      end
    end

    # size: mq, hq, maxres
    # num: default, 1, 2, 3
    def youtube_thumbnail(size="mq", num="default")
      "http://i.ytimg.com/vi/#{youtube_key}/#{size}#{num}.jpg"
    end

    def to_s
      @data
    end
  end
end
