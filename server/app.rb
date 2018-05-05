require "sinatra/base"
require "sinatra/reloader"

require "./templates/helpers/erb_helper"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :public_folder, "docs"
  set :bind, "0.0.0.0"

  include ERBHelper

  before do
    @floor = request.path.split("/").size - 2
  end

  get "/" do
    redirect "/index.html"
  end

  get "/index.html" do
    erb :index, {title: nil}
  end



  def link(path)
    "./#{"../"*@floor}#{path}"
  end
end
