require "yaml"
require "./musiki/helpers/sns_helper"
require "./musiki/helpers/country_helper"
require "./musiki/helpers/genre_helper"
require "./musiki/helpers/active_helper"
require "./musiki/helpers/video_helper"
require "./musiki/helpers/date_helper"

class Metadata
  def self.attr_writer(*vars)
    @attributes ||= []
    @attributes.concat vars
    super(*vars)
  end

  def self.attributes
    @attributes || []
  end

  def initialize(yaml_path)
    @metadata = YAML.load_file(yaml_path)
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

  include SNSHelper
  include CountryHelper
  include GenreHelper
  include ActiveHelper
  include VideoHelper
  include DateHelper
end
