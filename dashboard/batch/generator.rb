require 'httpclient'
require 'active_support/core_ext/string'
require './batch/generate_helper'

module Grock
  
  API_URI = ENV['API_URI'] || 'http://localhost:9292'
  
  class Generator
    def initialize
      
    end
    
    def exec
      load_data
      
      generate_index_page
      generate_posts_page
      generate_post_page
      generate_labels_page
      generate_discs_page
      generate_bands_page
      generate_band_page
      generate_404_page
      1
    end
    
    def request_data(client, name)
      items = JSON.parse(client.get("#{API_URI}/api/list/#{name}").body)['items'] ||= []
      items.map do |hash|
        yield hash
      end
    end
    
    def load_data
      client = HTTPClient.new
      
      @labels = request_data(client, "label") do |hash|
        item = Item.new(hash)
        Item.band_hash(hash['key'], item)
        item
      end
      @labels = @labels.sort_by {|item| item[:key]}
      
      @bands = request_data(client, "band") do |hash|
        item = Item.new(hash)
        Item.band_hash(hash['key'], item)
        item
      end
      @bands = @bands.sort_by {|item| item[:key]}
      
      # TODO dateでそーと
      @discs = request_data(client, "disc") do |hash|
        item = Item.new(hash)
        item.bands.each do |band|
          Item.band_discs(band, item)
        end
        item
      end
      @discs = @discs.sort_by {|item| item.release_date}.reverse
      
      @videos = request_data(client, "video") do |hash|
        Item.new(hash)
      end
      # TODO sort
      
      @posts = request_data(client, "post") do |hash|
        item = Item.new(hash)
        item.bands.each do |band|
          Item.band_posts(band, item)
        end
        item
      end
      @posts = @posts.delete_if {|post| post[:date].empty? } if ENV['RAKE_ENV'] == 'production'
      @posts = @posts.sort_by {|item| item[:date]}.reverse
      
      @locals = {
        :posts => @posts,
        :bands => @bands,
        :discs => @discs,
        :new_releases => new_releases,
        :labels => @labels
      }
    end
    
    def new_releases
      today = Date.today
      new_discs = []
      @discs.each_with_index do |disc, i|
        if disc.release_date >= today - 60
          new_discs << disc
        elsif new_discs.size < 9
          new_discs << disc
        else
          break
        end
      end
      new_discs
    end
    
    def output(name, locals={}, filename=nil)
      locals = @locals.merge(locals)
      locals[:path] = "." * (filename || name).to_s.split('/').size
      Template.new(locals).instance_eval {
        html = ERB.new(File.read("templates/#{name}.erb")).result(binding)
        File.write("gh-pages/#{filename || name}.html", html)
      }
    end
    
    def generate_index_page
      @posts.each_with_index do |post, i|
        locals = {
          :post => post,
          :prev_post => i == 0 ? nil : @posts[i-1],
          :next_post => i == @posts.size-1 ? nil : @posts[i+1]
        }
        output :post, locals, "index"
        break;
      end
    end
    
    def generate_post_page
      @posts.each_with_index do |post, i|
        locals = {
          :post => post,
          :prev_post => i == 0 ? nil : @posts[i-1],
          :next_post => i == @posts.size-1 ? nil : @posts[i+1]
        }
        output :post, locals, "posts/#{post[:key]}"
      end
    end
    
    def generate_posts_page
      output :posts
    end
    
    def generate_labels_page
      output :labels
    end
    
    def generate_discs_page
      output :discs
    end
    
    def generate_bands_page
      output :bands
    end
    
    def generate_band_page
      @bands.each_with_index do |band, i|
        locals = {:band => band}
        output :band, locals, "bands/#{band[:key]}"
      end
    end
    
    def generate_404_page
      output '404'
    end
  end
end
