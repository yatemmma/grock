require "simple-rss"
require "open-uri"

module GROCK
  module Collectors
    class RSS
      def get_rss
        url = "https://www.theprp.com/feed/"
        # url = "http://scream.your.name"
        raw = open(url).read
        # p raw.read

        rss = SimpleRSS.parse(StringIO.new(raw))
        p rss
        # rss
      end
    end

    RSS.new.get_rss
  end
end
