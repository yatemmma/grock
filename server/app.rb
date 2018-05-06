require "sinatra/base"
require "sinatra/reloader"
require "sinatra/activerecord"

require "./models/models"
require "./templates/helpers/erb_helper"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    register Sinatra::ActiveRecordExtension
  end

  set :database, {adapter: "sqlite3", database: "db/database.sqlite3"}
  set :public_folder, "docs"
  set :bind, "0.0.0.0"

  include ERBHelper

  def initialize(app = nil)
    @is_admin = true
    super

    @labels = Label.all
    @feeds = Feed.all
  end

  before do
    @floor = request.path.split("/").size - 2
  end

  before :method => :post do
    params.delete("id")
    params.delete("type")
    params.delete("captures")
  end

  get "/" do
    redirect "/index.html"
  end

  get "/index.html" do
    erb :index, {title: nil}
  end

  get "/admin/api/update_feed" do
    feed = Crowler.new(params["model"], params["code"])
    feed.twitter_update
    200
  end
end

require_relative "./label_controller"
require_relative "./admin_controller"

require "simple-rss"
require "open-uri"

class Crowler
  def initialize(type, code)
    clazz = Object.const_get(type.capitalize)
    @item = clazz.find_by(code: code)
  end

  def twitter_update
    return if @item.twitter_key.nil?
    results = Twitter.rss(@item.code, @item.twitter_key)
    feed_ids = Feed.find_by(owner: @item.code) {|x| x.code}
    results.each do |result|
      unless (feed_ids || []).include?(result[:code])
        feed = Feed.create(result)
        feed.save
      end
    end
  end
end

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
            "<div class=\"image\" data-image=\"#{$2}\"><img></div>"
          }
          body = body.gsub(/ href=/){" target=\"_blank\" href="}

          info = {
            code: "#{code}_#{item[:guid]}",
            owner: code,
            type: "twitter",
            icon: rss.channel.image,
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
