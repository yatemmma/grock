module GROCK
  module SNSHelper
    DOMAIN = "https://scream.your.name"

    def twitter_share_link(url, text)
      # https://dev.twitter.com/web/tweet-button/parameters
      url = URI.escape url
      text = URI.escape text
      hashtags = URI.escape "G-ROCK"
      "https://twitter.com/share?url=#{url}&hashtags=#{hashtags}&text=#{text}"
    end

    def sns_block(item)
      url = "#{DOMAIN}/#{item.class.id}/#{item.code}.html"

      html = <<-"EOS"
        <div class="sns">
          <a href="#{twitter_share_link(url, item.title)}" target="_blank">
            <img src="#{link "assets/images/share_twitter.png"}">
          </a>
        </div>
      EOS
    end
  end
end
