require "active_support/core_ext/string/inflections"
require "fileutils"
require "yaml"
require "./musiki/models/member"
require "./musiki/models/label"
require "./musiki/models/song"
require "./musiki/models/disc"
require "./musiki/models/band"

class Reader
  def self.read(names)
    data = {}
    names.each do |name|
      data[name.to_sym] = load_data(name)
      Metadata.send("#{name}=",load_data(name))
    end
    data
  end

  def self.load_data(name)
    clazz = Object.const_get(name.camelize)
    metadata = {}
    Dir.glob("data/#{name}/*").each do |path|
      object = YAML.load_file(path)
      if object.is_a? Array
        object.each do |item|
          data = clazz.new(item)
          metadata[data.code] = data
        end
      else
        data = clazz.new(object)
        metadata[data.code] = data
      end
    end
    metadata
  end
end
