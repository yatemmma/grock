require 'yaml'
require 'erb'
require 'json'
require 'httpclient'
require 'active_support/core_ext/string'

require './models/model'

API_URI = ENV['API_URI'] || 'http://localhost:9292'
OUT_DIR = 'public'

def run
  client = HTTPClient.new
  @posts = JSON.parse(client.get("#{API_URI}/api/posts").body)['items']
  @posts.delete_if do |post|
    post['date'].empty?
  end if ENV['RAKE_ENV'] == 'production'
  p @posts
  
  @bands = JSON.parse(client.get("#{API_URI}/api/bands").body)['items']
  p @bands
  
  @discs = JSON.parse(client.get("#{API_URI}/api/discs").body)['items']
  p @discs
  
  @labels = JSON.parse(client.get("#{API_URI}/api/labels").body)['items']
  p @labels
  p "---------"
  
  @locals = {
    :posts => @posts,
    :bands => @bands,
    :discs => @discs,
    :labels => @labels
  }
  
  generate_index_page
  generate_posts_page
  generate_post_page
  generate_404_page
end

def generate_index_page
  @posts.each_model_with_index('posts') do |post, i|
    locals = {
      :path => '.',
      :post => post,
      :prev_post => i == 0 ? nil : @posts[i-1],
      :next_post => i == @posts.size-1 ? nil : @posts[i+1]
    }
    output :post, locals, "index"
    break;
  end
  
end

def generate_post_page
  @posts.each_model_with_index('posts') do |post, i|
    locals = {
      :path => '..',
      :post => post,
      :prev_post => i == 0 ? nil : @posts[i-1],
      :next_post => i == @posts.size-1 ? nil : @posts[i+1]
    }
    output :post, locals, "posts/#{post['url']}"
  end
end

def generate_posts_page
  output :posts, {:path => '.'}
end

def generate_404_page
  output '404', {:path => '.', :posts => @posts}
end

class View
  def initialize(locals)
    locals.each {|key, val|
      self.class.send(:define_method, key) { val }
    }
  end
  
  def partial(name, locals={})
    locals.each {|key, val|
      self.class.send(:define_method, key) { val }
    }
    ERB.new(File.read("generator/templates/partials/#{name}.erb"), nil, nil, eoutvar='_erbout2').result(binding)
  end
  
  def development?
    ENV['RAKE_ENV'].empty? || ENV['RAKE_ENV'] == 'development'
  end
  
  def production?
    ENV['RAKE_ENV'] == 'production'
  end
end

def output(name, locals={}, filename=nil)
  View.new(@locals.merge(locals)).instance_eval {
    html = ERB.new(File.read("generator/templates/#{name}.erb")).result(binding)
    File.write("#{OUT_DIR}/#{filename || name}.html", html)
  }
end

run
