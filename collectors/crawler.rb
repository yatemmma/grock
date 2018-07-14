require "simple-rss"
require "open-uri"

require "./models/models"

module GROCK
  class Crawler
    def get_rss(url)
      begin
        source = open(url).read
      rescue => e
        error = e.to_s
      end

      m = RawFeed.create(
        url: url,
        source: source,
        error: error
      )
      unless m.valid?
        RawFeed.create(
          url: url,
          error: m.errors.messages.to_s
        )
      end
    end
  end


end
