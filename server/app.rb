require "sinatra/base"
require "sinatra/reloader"
require "sinatra/activerecord"

require "./models/models"
require "./utils/importer"
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
    @settings = Setting.all
  end

  before do
    @floor = request.path.split("/").size - 2
  end

  get "/" do
    redirect "/index.html"
  end

  get "/index.html" do
    erb :index, {title: nil}
  end

  get "/labels.html" do
    erb :labels, {title: "Labels"}
  end

  get "/label/:id.html" do |id|
    @label = Label.find_by(code: id)
    erb :label, {title: "Labels", label: @label}
  end

  post "/admin/api/settings" do
    setting = Setting.find_by(code: params["code"])
    setting.json = params["json"]
    setting.save
    @settings = Setting.all
    200
  end
end

require_relative "./label_controller"
require_relative "./admin_controller"
