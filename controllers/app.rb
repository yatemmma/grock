require "sinatra/base"
require "sinatra/reloader"

require "./models/_models"
require "./services/_services"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :method_override
  set :views, "#{settings.root}/../views"

  get "/" do
    erb :index, locals: {}
  end

  get "/admin/" do
    erb :"admin/index", :layout => :"admin/layout", locals: {}
  end
end

require_relative "./admin/site"
require_relative "./site"
