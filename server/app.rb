require "sinatra/base"
require "sinatra/reloader"

require "./templates/helpers/erb_helper"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  include ERBHelper

  get "/" do
    "Hello world!"
  end

  get "/index.html" do
    erb :index
  end
end
