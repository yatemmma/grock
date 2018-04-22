require "simple-rss"
require "open-uri"

module TwitterFeed
  def self.get(key)
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
          title: "@#{key} on Twitter",
          url: item[:link],
          date: item[:pubDate].getlocal.strftime("%Y/%m/%d %H:%M:%S"),
          body: body,
          image: ""
        }
        result << info
      end
    end
    result
  end
end
