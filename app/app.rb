require "sinatra/base"
require "./models/site"

class App < Sinatra::Base
  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  set :public_folder, "public"

  get "/" do
    erb :index
  end

  get "/sites" do
    items = Site.order(:id)
    erb :sites, locals: {items: items}
  end

  get "/sites/:id" do |id|
    item = Site[id]
    erb :site, locals: {item: item}
  end
end
