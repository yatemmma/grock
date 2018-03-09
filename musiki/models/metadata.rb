require "yaml"
require "active_support/all"

class Metadata
  attr_accessor :code

  def self.attr_accessor(*vars)
    @attributes ||= []
    @attributes.concat vars
    super(*vars)
  end

  def self.attributes
    @attributes
  end

  def initialize(yaml_path)
    @metadata = HashWithIndifferentAccess.new(YAML.load_file(yaml_path))
  end

  def to_s
    @metadata.to_s
  end

  def code
    @metadata[:code]
  end
end
