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
end

require_relative "./label_controller"
require_relative "./admin_controller"
