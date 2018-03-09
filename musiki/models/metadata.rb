require "yaml"
require "active_support/all"

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
    @metadata = HashWithIndifferentAccess.new(YAML.load_file(yaml_path))
  end

  def contents
    @metadata
  end

  def to_s
    @metadata.to_s
  end

  def method_missing(method_name, *args)
    if self.class.attributes.include? method_name
      @metadata[method_name.to_sym]
    else
      super
    end
  end
end
