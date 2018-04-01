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

    def to_s
      @data
    end
  end
end
