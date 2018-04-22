require "yaml"
require "time"
require "erb"
require "fileutils"
require "open-uri"

require_relative "./feed/twitter"

class Crowler
  class << self
    def feeds(item)
      feed_results = []
      unless (item.twitter.nil? || item.twitter.empty?)
        key = item.twitter.split(" ").first.split("/").last
        feed_results = feed_results.concat TwitterFeed.get(key)
      end
      feed_results = feed_results.sort_by do |feed|
        feed[:date]
      end
      feed_results = feed_results.reverse
    end
  end
end
