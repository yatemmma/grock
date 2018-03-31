require "./musiki/models/helpers/helper"

class Metadata
  def self.prop(name, type=String)
    @attributes ||= []
    @attributes << [name, type]
  end

  def self.attributes
    (@attributes || []).map {|prop| prop.first}
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

  def get_prop(name)
    @metadata[name]
  end

  def admin?
    ENV["ADMIN"].to_s == "true"
  end

  def method_missing(method_name, *args)
    if self.class.attributes.include? method_name
      return get_prop(method_name.to_s)
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

  class << self
    attr_accessor :band
    attr_accessor :disc
    attr_accessor :label
    attr_accessor :member
    attr_accessor :song
  end

  def videos?
    (videos || []).map do |video|
      Metadata.song[video]
    end
  end

  def discs?
    (discs || []).map do |disc|
      Metadata.disc[disc]
    end
  end

  def guests?
    (guests || []).map do |guest|
      [Metadata.member[guest["code"]], guest]
    end
  end

  include AttributeHelper
end
