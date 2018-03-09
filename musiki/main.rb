require "erb"
require "fileutils"
require "active_support/core_ext/string/inflections"
require "./musiki/models/member"

def load_data(name)
  clazz = Object.const_get(name.camelize)
  p clazz.attributes
  metadata = {}
  Dir.glob("src/#{name}/*").each do |path|
    data = clazz.new(path)
    metadata[data.code] = data
  end
  metadata
end

def output_html(obj, name, file)
  contents = File.read("musiki/templates/#{name}.erb")
  path = "output/#{file}.html"
  FileUtils.mkdir_p(File.dirname(path))
  File.write(path, ERB.new(contents).result(binding))
end

def output_items(items, name)
  output_html(items, name.pluralize, name.pluralize)
  items.each do |code, obj|
   output_html(obj, name, "#{name}/#{obj.code}")
  end
end

def output_index
  output_html({}, "index", "index")
end

FileUtils.rm_rf("output")

list = %w(member)

@data = {}
list.each do |name|
  @data[name.to_sym] = load_data(name)
end

list.each do |name|
  output_items(@data[name.to_sym], name)
end
output_index

puts @data
