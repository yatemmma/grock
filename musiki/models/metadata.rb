require "./musiki/models/helpers/helper"

class Metadata
  def self.attr_writer(*vars)
    @attributes ||= []
    @attributes.concat vars
    super(*vars)
  end

  def self.attributes
    @attributes || []
  end

  def initialize(hash)
    @metadata = hash
  end

  def contents
    @metadata
  end

  def to_s
    @metadata.to_s
  end

  class << self
    attr_accessor :band
    attr_accessor :disc
    attr_accessor :label
    attr_accessor :member
    attr_accessor :song
  end

  def method_missing(method_name, *args)
    if self.class.attributes.include? method_name
      return @metadata[method_name.to_s]
    end

    method = method_name.to_s[0..-2]
    if ((method_name.to_s[-1] == "?") &&
         (self.class.attributes.include? method.to_sym))
      item = Metadata.send(method)[@metadata[method]]
      if item.nil?
        puts "#{@metadata[method]} is missing at #{method}"
        return @metadata[method]
      else
        return item
      end
    end

    super
  end

  include AttributeHelper
end
