require "sinatra/base"
require "sinatra/reloader"

require "./models/models"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :method_override

  get "/" do
    items = GROCK::FeedUrl.all
    erb :index, locals: {items: items}
  end

  get "/news_sites" do
    items = GROCK::NewsSite.all
    erb :news_sites, locals: {items: items}
  end

  get "/news_site/new" do
    erb :news_site, locals: {item: GROCK::NewsSite.new, method: "post"}
  end

  get "/news_site/:code/edit" do |code|
    item = GROCK::NewsSite.find_by(code: code)
    if item.nil?
      404
    else
      erb :news_site, locals: {item: item, method: "put"}
    end
  end

  post "/news_site/new" do
    p 222
    params["entry"].to_s
    GROCK::NewsSite.create(params[:entry])
    redirect "/news_site/#{params[:entry]["code"]}/edit"
  end

  put "/news_site/:code" do |code|
    item = GROCK::NewsSite.find_by(code: code)
    if item.nil?
      404
    else
      GROCK::NewsSite.update(code, params[:entry])
      redirect "/news_site/#{params[:entry]["code"]}/edit"
    end
  end
end
