require "active_support/core_ext/string/inflections"
require "fileutils"
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
    end
    data
  end

  def self.load_data(name)
    clazz = Object.const_get(name.camelize)
    metadata = {}
    Dir.glob("src/#{name}/*").each do |path|
      data = clazz.new(path)
      metadata[data.code] = data
    end
    metadata
  end
end
