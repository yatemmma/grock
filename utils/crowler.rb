require "simple-rss"
require "open-uri"
require_relative "./feeds/site"
require_relative "./feeds/twitter"
require_relative "./feeds/youtube"

class Crowler
  def initialize(type, code)
    clazz = Object.const_get(type.capitalize)
    @item = clazz.find_by(code: code)
  end

  def update
    results = []
    unless (@item.twitter.nil? || @item.twitter.empty?)
      results += Twitter.rss(@item.code, @item.twitter_key)
    end
    unless (@item.youtube.nil? || @item.youtube.empty?)
      key, value = @item.youtube_key
      results += YouTube.atom(@item.code, key, value)
    end
    unless (@item.feeds.nil? || @item.feeds.empty?)
      @item.feeds.split(",").each do |feed_url|
        results += FeedParser.rss(@item.code, feed_url)
      end
    end

    feed_ids = Feed.where(owner: @item.code) {|x| x.code}
    results.each do |result|
      result[:owner_name] = @item.name
      unless (feed_ids || []).include?(result[:code])
        begin
          feed = Feed.create(result)
          feed.save
        rescue ActiveRecord::RecordNotUnique => ex
          puts ex
        end
      end
    end
    @item.touch if Feed.where(owner: @item.code).count > feed_ids.length
    @item.save
  end
end
