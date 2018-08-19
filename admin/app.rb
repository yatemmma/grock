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
end
