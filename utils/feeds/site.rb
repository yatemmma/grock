class FeedParser
  class << self
    def rss(code, url)
      rss = SimpleRSS.parse open(url)
      results = []
      p 111, rss.channel
      rss.items.each do |item|

        body = item[:description] || ""
        body = body.gsub(/(\[\.\.\.\])/){
          "<a href=\"#{item[:link]}\" target=\"_blank\">#{$1}</a>"
        }
        body = "<p>#{item[:title]}</p><p>#{body}</p>"

        info = {
           code: "#{code}_#{item[:id] || item[:link]}",
           owner: code,
           feed_type: :site,
           icon: nil,
           url: item[:link],
           date: item[:published] || rss.channel.lastBuildDate,
           title: item[:title],
           body: body
        }
        results << info
      end
      results
    end
  end
end
