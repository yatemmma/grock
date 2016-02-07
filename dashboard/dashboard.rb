require 'sinatra'
require 'sinatra/base'
# require 'sinatra/reloader' if development?
require 'tilt/erb'
require 'active_support/core_ext/string'
require 'json'
require 'date'
require 'google_custom_search_api'

require './config/initialize'
require './models/model'
require './views/helper'
require './lib/post_twitter'

GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']
GOOGLE_SEARCH_CX = ENV['GOOGLE_SEARCH_CX']

module Grock
  class Dashboard < Sinatra::Base
    configure :development do
      # register Sinatra::Reloader
    end
    
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

    helpers ViewUtils
    
    get '/' do
      protect!
      erb :index
    end
    
    get '/list/:item_name' do |name|
      protect!
      clazz = Module.const_get("Grock::#{name.camelize}")
      erb :list, locals: {name: name, columns: clazz.all_columns, items: clazz.load}
    end
    
    get '/detail/:item_name/:id' do |name, id|
      protect!
      clazz = Module.const_get("Grock::#{name.camelize}")
      erb :detail, locals: {name: name, columns: clazz.all_columns, item: clazz.find_by_id(id)}
    end
    put '/detail/:item_name/' do |name|
      protect!
      clazz = Module.const_get("Grock::#{name.camelize}")
      item = clazz.new
      item.save_values params
      content_type :json
      {item: item}.to_json
    end
    post '/detail/:item_name/:id' do |name, id|
      protect!
      clazz = Module.const_get("Grock::#{name.camelize}")
      item = clazz.find_by_id(id)
      item.save_values params
      content_type :json
      {item: item}.to_json
    end
    delete '/detail/:item_name/:id' do |name, id|
      protect!
      clazz = Module.const_get("Grock::#{name.camelize}")
      item = clazz.find_by_id(id)
      item.destroy
      content_type :json
      {}.to_json
    end
    
    get '/api/list/:item_name' do |name|
      clazz = Module.const_get("Grock::#{name.camelize}")
      content_type :json
      {items: clazz.load_hash}.to_json
    end
    
    get '/ajax/google/:word' do |word|
      protect!
      results = GoogleCustomSearchApi.search(URI.decode(word))
      results["items"].each do |item|
        puts "#{item['title']} #{item['link']}"
      end
      content_type :json
      {items: results["items"]}.to_json
    end
    
    get '/job/post_twitter' do
      protect!
      today = Date.today.strftime("%Y/%m/%d")
      today_post = Grock::Post.load_hash.find do |post|
        post['date'] == today
      end
      return if today_post.nil?
      
      text = "[G-ROCK] #{today_post['title']} http://scream.your.name/posts/#{today_post[:key]}.html"
      Grock::PostTwitter.new.post(text)
      
      "OK"
    end
  end
end
