class Array
  def each_model(name=nil)
    self.each do |hash|
      name = self['type'] if name.nil?
      clazz = Module.const_get(name.singularize.camelcase)
      yield(clazz.new(hash))
    end
  end
  
  def each_model_with_index(name=nil)
    self.each_with_index do |hash, i|
      name = self['type'] if name.nil?
      clazz = Module.const_get(name.singularize.camelcase)
      yield(clazz.new(hash), i)
    end
  end
end

class Model
  def initialize(hash)
    @hash = hash
  end
  
  def [](key)
    @hash[key]
  end
end

require './models/post'
require './models/band'
require './models/disc'
require './models/label'
