require "sinatra"
require "sinatra/activerecord"
require "active_support/core_ext/string/inflections"
require "net/http"
require "uri"
require "yaml"
require "pry"

set :database, "sqlite3:db/database.sqlite3"
set :views, "templates", "templates/partials"
set :public_folder, "public"

require "./models/models"
require "./server/template_helper"
require "./server/crowl"

include TemplateHelper

before do
  @floor = request.path.split("/").size - 2
end

get "/index.html" do
  content_type :json
	erb :index
end

get "/api/site_title" do
  uri = URI.parse(params["url"])
  body = Net::HTTP.get(uri)
  body.match(/<title.*?>(.+)<\/title>/i)[1]
end

get "/api/feeds" do
  id = params["id"]
  @item = Band.find_by(code: id) || Label.find_by(code: id)
  feeds = Crowler.feeds(@item).to_json
  @item.update(feeds: feeds)
  p feeds
  200
end

get "/export" do
  [Band, Disc, Label].each do |clazz|
    yaml = clazz.all.map {|item| item.as_json}.to_yaml
    File.write("db/yaml/#{clazz.name.downcase}.yml", yaml)
  end
  200
end

get "/import" do
  [Band, Disc, Label].each do |clazz|
    clazz.delete_all
    records = YAML.load_file("db/yaml/#{clazz.name.downcase}.yml")
    records.each do |record|
      item = clazz.create(record)
      item.save
    end
  end
  200
end

get "/tools" do
  @key = youtube_key(params["url"])
  erb :tools
end

get "/:types.html" do |types|
  clazz = Object.const_get(types.singularize.capitalize)
  @items = clazz.all
  erb types.pluralize.to_sym
end

get "/:type/:id.html" do |type, id|
  clazz = Object.const_get(type.capitalize)
	@item = clazz.find_by(code: id)
  if @item.nil?
    404
  else
    @bands = Band.all
    if type == "disc"
      @discs = Disc.all
      @labels = Label.all
    end
    @items = clazz.all
    erb type.to_sym
  end
end

get "/:type/new" do |type|
  clazz = Object.const_get(type.capitalize)
  @bands = Band.all
  if type == "disc"
    @discs = Disc.all
    @labels = Label.all
  end
	@item = clazz.new
  erb type.to_sym
end

post "/:type/delete" do |type|
  clazz = Object.const_get(type.capitalize)
	@item = clazz.find_by(code: params[:code])
	@item.destroy
  redirect "/#{type.pluralize}.html"
end

post "/:type/:id" do |type, id|
  p params
  params.delete("id")
  params.delete("type")
  params.delete("captures")
  clazz = Object.const_get(type.capitalize)
  @item = clazz.find_by(code: id)
  if @item.nil?
    @item = clazz.create(params)
  else
    @item.update(params)
  end
  @item.save
  redirect "/#{type}/#{id}.html"
end
