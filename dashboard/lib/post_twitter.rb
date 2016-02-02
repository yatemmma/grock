require 'twitter'

module Grock
  class PostTwitter
    def post(text)
      client = Twitter::REST::Client.new(
        consumer_key:        ENV['TWITTER_CONSUMER_KEY'],
        consumer_secret:     ENV['TWITTER_CONSUMER_SECRET'],
        access_token:        ENV['TWITTER_ACCESS_TOKEN'],
        access_token_secret: ENV['TWITTER_CONSUMER_KEY_SECRET']
      )
      timeline = client.user_timeline 'prettygereen'
      matched = timeline.any? {|tweet| tweet.body('http').first == text.split('http').first}
      client.update text unless matched
    end
  end
end
