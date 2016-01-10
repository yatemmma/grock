require 'sinatra'
require 'sinatra/reloader' if development?
require 'sequel'
require 'yaml'
require 'json'

require './app/models/common_model'

config = YAML.load_file("app/config/#{ENV['RACK_ENV']}.yml")
DB = Sequel.connect(ENV['DATABASE_URL'] || config[:database])

get '/' do
  erb :index, :locals => {}
end

get '/:path' do |path|
  items = CommonModel.all(path)
  items << {} if items.empty?
  erb path.to_sym, :locals => {:path => path, :cols => CommonModel.cols(path), :items => items}
end

get '/post/:id' do |id|
  post = CommonModel.new('posts', id).to_h
  erb :post, :locals => {:post => post}
end

get '/api/:path' do |path|
  p "get:#{path} #{params}"
  items = CommonModel.all(path)
  content_type :json
  {items: items}.to_json
end

post '/api/:path' do |path|
  p "post:#{path} #{params}"
  params[:id] = "#{Time.now.to_i}" if params[:id].empty?
  item = CommonModel.add(path, params)
  content_type :json
  {id: params[:id]}.to_json
end

put '/api/:path' do |path|
  p "put:#{path} #{params}"
  item = CommonModel.new(path, params[:id]).update(params)
  content_type :json
  {item: item}.to_json
end

delete '/api/:path' do |path|
  p "delete:#{path} #{params}"
  item = CommonModel.new(path, params[:id]).delete
  content_type :json
  {item: item}.to_json
end
