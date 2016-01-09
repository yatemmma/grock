require 'sinatra'

get '/' do
  erb :index
end

post '/update' do
  p params[:test]
  'updated'
end
