require "sinatra/base"

class Admin < Sinatra::Base
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
    if id == "new"
      item = Site.new
    else
      item = Site[id]
    end
    erb :site, locals: {item: item}
  end

  post "/sites" do
    item = Site.new(params["entry"])
    item.save if item.valid?
    redirect "/sites"
  end
end
