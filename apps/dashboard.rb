require 'sinatra'
require 'sequel'
require 'yaml'
require 'json'

config = YAML.load_file("apps/config/#{ENV['RACK_ENV']}.yml")
DB = Sequel.connect(ENV['DATABASE_URL'] || config[:database])

# dashboard request
get '/' do
  items = DB[:items]
  if items.count <= 0
    items.insert(:name => 'fugafuga')
    items = DB[:items]
  end
  p items.where(:id => 1).first[:name]
  erb :index, :locals => {:word => items.where(:id => 1).first[:name]}
end

post '/update' do
  items = DB[:items]

  items.where(:id => 1).update(:name => params[:test])
  p params[:test]
  'updated'
end

# web api
get '/data/name' do
  items = DB[:items]
  content_type :json
  data = {name: items.where(:id => 1).first[:name]}
  data.to_json
end

post '/data/name' do
  p params[:name]
end
