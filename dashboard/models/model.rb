module Grock
  module ClassModel
    def load
      self.all
    end
    
    def load_hash
      self.all.map {|item| item.to_h}
    end
    
    def all_columns
      %w(id key) + Settings.columns[self.identifier]
    end
    
    def find_by_id(id)
      return self.new if id.to_i == 0
      self.find(id)
    end
  end
  
  module InstanceModel
    def save_values(hash)
      self.key = hash['key'] ||= hash[:key]
      self.values = hash.select {|k,v| Settings.columns[self.class.send(:identifier)].include? k.to_s}.to_json
      save!
    end
    
    def to_h
      hash = JSON.parse(self.values)
      hash[:id] = self.id
      hash[:key] = self.key
      hash
    end
    
    def method_missing(name)
      if Settings.columns[self.class.send(:identifier)].include? name.to_s
        if self.values.nil?
          nil
        else
          JSON.parse(self.values)[name.to_s]
        end
      else
        super
      end
    end
  end
end

require './models/label'
require './models/post'
require './models/band'
require './models/video'
require './models/disc'
