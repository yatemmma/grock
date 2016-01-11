require 'sinatra'
require 'sinatra/reloader' if development?
require 'sequel'
require 'yaml'
require 'json'

require './app/models/common_model'

helpers do
  def protect!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end
  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    username = ENV['GROCK_USERNAME']
    password = ENV['GROCK_PASSWORD']
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [username, password]
  end
end

config = YAML.load_file("app/config/#{ENV['RACK_ENV']}.yml")
DB = Sequel.connect(ENV['DATABASE_URL'] || config[:database])

IS_DEV = development?

get '/' do
  protect!
  erb :index, :locals => {:dev => IS_DEV}
end

get '/:path' do |path|
  protect!
  items = CommonModel.all(path)
  items << {} if items.empty?
  erb path.to_sym, :locals => {:dev => IS_DEV, :path => path, :cols => CommonModel.cols(path), :items => items}
end

get '/post/:id' do |id|
  protect!
  post = CommonModel.new('posts', id).to_h
  erb :post, :locals => {:dev => IS_DEV, :post => post}
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
