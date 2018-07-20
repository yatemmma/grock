require "sinatra/base"
require "sinatra/reloader"

require "./models/models"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :method_override

  get "/" do
    erb :index, locals: {}
  end

  # get "/band/hoge" do
  #   item = GROCK::Band.new
  #   erb :band, locals: {item: item}
  # end
  #
  # post "/band/hoge" do
  #   p params[:entry]
  #   ActiveRecord::Base.transaction do
  #     params[:links].values.transpose.map do|values|
  #       GROCK::Link.create(params[:links].keys.zip(values).to_h)
  #     end
  #     item = GROCK::Band.create(params[:band])
  #   end
  #   redirect "/band/hoge"
  # end
  #
  #
  # get "/news_sites" do
  #   items = GROCK::NewsSite.all
  #   erb :news_sites, locals: {items: items}
  # end
  #
  # get "/news_site/new" do
  #   erb :news_site, locals: {item: GROCK::NewsSite.new, method: "post"}
  # end
  #
  # get "/news_site/:code/edit" do |code|
  #   item = GROCK::NewsSite.find_by(code: code)
  #   if item.nil?
  #     404
  #   else
  #     raw_feeds = GROCK::RawFeed.where(url: item.feed_url).order(updated_at: :desc)
  #     erb :news_site, locals: {item: item, method: "put", raw_feeds: raw_feeds}
  #   end
  # end
  #
  # get "/news_site/:code/get_feed" do |code|
  #   item = GROCK::NewsSite.find_by(code: code)
  #   if item.nil?
  #     404
  #   else
  #     # GROCK::Crawler.new.get_rss item.feed_url
  #     require "simple-rss"
  #     raw_feeds = GROCK::RawFeed.where(url: item.feed_url, error: nil, parsed: false)
  #                               .order(updated_at: :asc)
  #     raw_feeds.each do |raw_feed|
  #       rss = SimpleRSS.parse(StringIO.new(raw_feed.source))
  #       rss.items.each do |rss_item|
  #                 p "#{code}_#{rss_item[:guid]}"
  #                 p code
  #                 p item.name
  #                 p :news_site
  #                 p "theprp_com"
  #                 p item.image_icon
  #                 p rss_item[:link]
  #                 p rss_item[:pubDate]
  #                 p rss_item[:title]
  #                 p rss_item[:description]
  #                 p rss_item[:category]
  #         # GROCK::Feed.create(
  #         #   code: "#{code}_#{rss_item[:guid]}",
  #         #   owner_code: code,
  #         #   owner_name: code,
  #         #   owner_type: code,
  #         #   feed_type: :twitter,
  #         #   icon: rss.channel.image.match(/^<url>(.*)<\/url>$/)[1],
  #         #   url: rss_item[:link],
  #         #   date: rss_item[:pubDate],
  #         #   title: "@#{twitter_key} on Twitter",
  #         #   body: body
  #         # )
  #       end
  #     end
  #
  #     redirect "/news_site/#{code}/edit"
  #   end
  # end
  #
  # post "/news_site/new" do
  #   GROCK::NewsSite.create(params[:entry])
  #   redirect "/news_site/#{params[:entry]["code"]}/edit"
  # end
  #
  # put "/news_site/:code" do |code|
  #   item = GROCK::NewsSite.find_by(code: code)
  #   if item.nil?
  #     404
  #   else
  #     GROCK::NewsSite.update(code, params[:entry])
  #     redirect "/news_site/#{params[:entry]["code"]}/edit"
  #   end
  # # end
end

require_relative "./site"
