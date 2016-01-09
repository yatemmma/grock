require 'sinatra'
require 'sequel'
require 'yaml'

config = YAML.load_file("config/#{ENV['RACK_ENV']}.yml")

get '/' do
  DB = Sequel.connect(config[:database])
  items = DB[:items]
  if items.count <= 0
    items.insert(:name => 'fugafuga')
    items = DB[:items]
  end
  p items.where(:id => 1).first[:name]
  erb :index, :locals => {:word => items.where(:id => 1).first[:name]}
end

post '/update' do
  DB = Sequel.connect(config[:database])
  items = DB[:items]

  items.where(:id => 1).update(:name => params[:test])
  p params[:test]
  'updated'
end
