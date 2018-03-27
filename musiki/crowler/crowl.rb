require "yaml"
require "time"
require "erb"
require "fileutils"
require "open-uri"

require "./musiki/crowler/feed/twitter.rb"

class Crowler
  def run
    @data = Reader.read(%w(member label song disc band))
    bands = []
    @data[:band].each do |band|
      code, data = band

      if code.start_with? ""
        #crowl_feed data
        search_data data

        bands << data
      end
    end

    contents = File.read("musiki/crowler/index.erb")
    path = "info/data/index.html"
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, ERB.new(contents).result(binding))
    system "open info/data/index.html"
  end

  def search_data(band)
    data = {
      titles: get_titles(band)
    }
    contents = File.read("musiki/crowler/template.erb")
    path = "info/data/#{band.code}.html"
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, ERB.new(contents).result(binding))
  end

  def get_titles(item)
    titles = {}
    %w(apple play spotify soundcloud bandcamp youtube website wikipedia twitter facebook instagram discogs).each do |key|
      if item.contents.has_key? key
        link = item.send(key)
        if ((link.is_a? Hash) && link["title"].nil?)
          url = link[:url]
        elsif (link.is_a? String)
          url = link
        end

        unless url.nil?
          open(url).read.match(/<title>(.*)<\/title>/)
          puts item.code, key, url, $1
        end
      end
    end
  end

  def crowl_feed(band)
    feed_results = []
    feed_results = feed_results.concat TwitterFeed.get(band.twitter_key) unless band.twitter.nil?
    feed_results = feed_results.sort_by do |feed|
      feed[:date]
    end
    feed_results = feed_results.reverse

    file_path = "info/feeds/feed##{band.code}.yaml"
    YAML.dump(feed_results, File.open(file_path, "w"))
  end
end
