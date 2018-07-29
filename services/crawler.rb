require "simple-rss"
require "open-uri"

module GROCK
  class Crawler
    class << self
      def get_source(link)

        case link.label
        when "youtube"
          value, key, _ = link.url.split("/").reverse
          request_url = "https://www.youtube.com/feeds/videos.xml?#{key}=#{value}"
        when "twitter"
          key = link.url.split("/").pop
          request_url = "http://twitrss.me/twitter_user_to_rss/?user=#{key}"
        else
          request_url = link.url
        end

        begin
          source = open(request_url, "Accept-Language" => "en-US").read
        rescue => e
          error = e.to_s
        end

        m = GROCK::Source.create(
          kind: link.kind,
          code: link.code,
          type: :rss,
          url: link.url,
          raw: source,
          error: error
        )
        unless m.valid?
          GROCK::Source.create(
            kind: link.kind,
            code: link.code,
            url: link.url,
            error: m.errors.messages.to_s
          )
        end
      end

    end
  end
end
