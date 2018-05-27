class Twitter
  class << self
    def rss(code, twitter_key)
      # use: http://twitrss.me/
      url = "http://twitrss.me/twitter_user_to_rss/?user=#{twitter_key}"
      rss = SimpleRSS.parse open(url)
      results = []
      rss.items.each do |item|
        if item[:link].downcase.start_with? "https://twitter.com/#{twitter_key}"

          body = item[:description] || ""
          body = body.gsub(/(<img[^>]* alt="([^"]*)" [^>]*><\/img>)/){"#{$2} "}
          body = body.gsub(/<a class=\"twitter-timeline-link[^<]*<\/a><\/a>/){""}
          body = body.gsub(/(<img[^>]* src="([^"]*)" [^>]*\/>)/){
            "<a href=\"#{item[:link]}\" target=\"_blank\"><div class=\"image\" data-image=\"#{$2}\"><img></div></a>"
          }
          body = body.gsub(/ href=/){" target=\"_blank\" href="}

          info = {
            code: "#{code}_#{item[:guid]}",
            owner: code,
            feed_type: :twitter,
            icon: rss.channel.image.match(/^<url>(.*)<\/url>$/)[1],
            url: item[:link],
            date: item[:pubDate],
            title: "@#{twitter_key} on Twitter",
            body: body
          }
          results << info
        end
      end
      results
    end
  end
end
