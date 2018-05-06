class YouTube
  class << self
    def atom(code, key, value)
      key = (key == "user" ? "user" : "channel_id")
      url = "https://www.youtube.com/feeds/videos.xml?#{key}=#{value}"
      rss = SimpleRSS.parse open(url)
      results = []
      rss.items.each do |item|
        body = "<p>#{item[:title]}</p>"
        body += "<a href=\"#{item[:link]}\" target=\"_blank\"><div class=\"image\" data-image=\"#{item[:media_thumbnail_url]}\"><img></div></a>"

        info = {
           code: "#{code}_#{item[:id]}",
           owner: code,
           feed_type: :youtube,
           icon: "https://i.ytimg.com/vi/IC6m249zvI0/hqdefault.jpg",
           url: item[:link],
           date: item[:published],
           title: item[:title],
           body: body
        }
        results << info
      end
      results
    end
  end
end
