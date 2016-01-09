require 'sinatra'
require 'sinatra/reloader' if development?
require 'sequel'
require 'yaml'
require 'json'

config = YAML.load_file("apps/config/#{ENV['RACK_ENV']}.yml")
DB = Sequel.connect(ENV['DATABASE_URL'] || config[:database])

get '/' do
  erb :index, :locals => {}
end

get '/dashboard/labels' do
  labels = DB[:labels].all
  labels << {} if labels.empty?
  erb :labels, :locals => {:cols => %w(id slug name nick site youtube), :items => labels}
end

get '/data/:path' do |path|
  p "get:#{path}"
  p params
  items = DB[path.to_sym]
  
  content_type :json
  {items: items.all}.to_json
end

post '/data/:path' do |path|
  p "post:#{path}"
  p params
  
  items = DB[path.to_sym]
  
  content_type :json
  data = {'success' => 0}
  data.to_json
end

put '/data/:path' do |path|
  p "put:#{path}"
  p params
  content_type :json
  data = {'success' => 1}
  data.to_json
end

delete '/data/:path' do |path|
  p "delete:#{path}"
  p params
  content_type :json
  data = {'success' => 3}
  data.to_json
end
