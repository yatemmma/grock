require 'sinatra'
require 'sequel'

get '/' do
  # DB = Sequel.connect('sqlite://db/test.db')
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/grock' || "sqlite://db/test.db")
  items = DB[:items]
  if items.count <= 0
    items.insert(:name => 'fugafuga')
    items = DB[:items]
  end
  p items.where(:id => 1).first[:name]
  erb :index, :locals => {:word => items.where(:id => 1).first[:name]}
end

post '/update' do
  # DB = Sequel.connect('sqlite://db/test.db')
  DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://localhost/grock' || "sqlite://db/test.db")
  items = DB[:items]

  items.where(:id => 1).update(:name => params[:test])
  p params[:test]
  'updated'
end
