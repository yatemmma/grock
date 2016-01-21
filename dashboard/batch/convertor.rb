require 'csv'
require './config/initialize'
require './models/model'

module Grock
  class Converter
    def initialize
      
    end
    
    def exec
      conv_csv :label, %w(id key name nick site youtube recommend)
      conv_csv :band, %w(id key name nick site wiki facebook twitter youtube soundcloud myspace purevolume lastfm instagram tumblr recommend)
      conv_csv :disc, %w(id key title bands date label image amazon itunes stream teaser free recommend)
      conv_csv :post, %w(id key title date bands type media recommend body)
      1
    end
    
    def conv_csv(name, keys)
      items = CSV.parse(File.read("db/dump_#{name.to_s}s.csv").gsub /\r/, '')
      items.each do |item|
        values = keys.inject({}) do |h, key|
          h[key] = item.shift
          h
        end
        p values
        
        clazz = Module.const_get "Grock::#{name.to_s.capitalize}"
        item = clazz.new
        item.save_values values
      end
    end
  end
end
