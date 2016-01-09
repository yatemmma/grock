require 'sinatra'
require 'sinatra/reloader' if development?
require 'sequel'
require 'yaml'
require 'json'
require 'active_support/core_ext/string'

require './apps/models/label'

config = YAML.load_file("apps/config/#{ENV['RACK_ENV']}.yml")
DB = Sequel.connect(ENV['DATABASE_URL'] || config[:database])

get '/' do
  erb :index, :locals => {}
end

get '/dashboard/labels' do
  labels = Label.all
  labels << {} if labels.empty?
  erb :labels, :locals => {:cols => Label.cols, :items => labels}
end

get '/data/:path' do |path|
  p "get:#{path} #{params}"
  model = Module.const_get(path.singularize.camelcase)
  content_type :json
  {items: model.all}.to_json
end

post '/data/:path' do |path|
  p "post:#{path} #{params}"
  model = Module.const_get(path.singularize.camelcase)
  item = model.add(params)
  content_type :json
  {item: item}.to_json
end

put '/data/:path' do |path|
  p "put:#{path} #{params}"
  model = Module.const_get(path.singularize.camelcase)
  p model.get(params[:id])
  item = model.new(params[:id]).update(params)
  p item
  content_type :json
  {item: item}.to_json
end

delete '/data/:path' do |path|
  p "delete:#{path} #{params}"
  model = Module.const_get(path.singularize.camelcase)
  item = model.new(params[:id]).delete
  content_type :json
  {item: item}.to_json
end
