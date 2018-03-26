require "uri"

module SNSHelper
  def twitter_share_link(url, text)
    # https://dev.twitter.com/web/tweet-button/parameters
    url = URI.escape url
    text = URI.escape text
    hashtags = URI.escape "G-ROCK"
    "https://twitter.com/share?url=#{url}&hashtags=#{hashtags}&text=#{text}"
  end

  #TODO: facebook
  #TODO: google
  #TODO: hatena
  #TODO: line
  #TODO: instagram
  #TODO: pintarest
  #TODO: tumblr

  def twitter_key
    twitter.split("/").last unless twitter.nil?
  end
end
