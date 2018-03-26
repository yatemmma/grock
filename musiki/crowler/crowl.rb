require "simple-rss"
require "open-uri"
require "yaml"

class Crowler
  def run
    @data = Reader.read(%w(member label song disc band))
    @data[:band].each do |band|
      code, data = band
      crowl_feed data if code == "awaken_i_am"
    end
  end

  def crowl_feed(band)
    feed_results = []
    feed_results = feed_results.concat twitter_feed(band.twitter_key) unless band.twitter.nil?

    # TODO: sort by date
    feed_results = feed_results.sort_by do |feed|
      feed[:date]
    end
    feed_results = feed_results.reverse

    file_path = "info/feeds/feed##{band.code}.yaml"
    YAML.dump(feed_results, File.open(file_path, "w"))
  end

  def twitter_feed(key)
    # use: http://twitrss.me/
    url = "http://twitrss.me/twitter_user_to_rss/?user=#{key}"
    rss = SimpleRSS.parse open(url)
    result = []
    rss.items.each do |item|
      if item[:link].downcase.start_with? "https://twitter.com/#{key}"

        body = item[:description] || ""
        body = body.gsub(/(<img[^>]* alt="([^"]*)" [^>]*><\/img>)/){"#{$2} "}
        body = body.gsub(/<a class=\"twitter-timeline-link[^<]*<\/a><\/a>/){""}
        body = body.gsub(/(<img[^>]* src="([^"]*)" [^>]*\/>)/){
          "<div class=\"image\" data-image=\"#{$2}\"><img></div>"
        }
        body = body.gsub(/ href=/){" target=\"_blank\" href="}

        info = {
          type: :twitter,
          title: "Tweet at " + item[:pubDate].to_s,
          url: item[:link],
          date: item[:pubDate],
          body: body,
          image: ""
        }
        result << info
      end
    end
    result
  end
end
