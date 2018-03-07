require "erb"
require "fileutils"
require "active_support/inflector"

require "./musiki/metadata"

def read_files(dir)
  data = {}
  Dir.glob("src/#{dir}/*").each do |path|
    text = File.read(path)
    metadata = Metadata.new(text)
    data[metadata[:code]] = metadata
  end
  data
end

def output_html(obj, template, file)
  contents = File.read("musiki/templates/#{template}.erb")
  path = "output/#{file}.html"
  FileUtils.mkdir_p(File.dirname(path))
  File.write(path, ERB.new(contents).result(binding))
end

def output_items(items, name)
  output_html(items, name.pluralize, name.pluralize)
  items.each do |code, obj|
    output_html(obj, name, "#{name}/#{obj[:code]}")
  end
end

def output_index
  output_html({}, "index", "index")
end

@labels = read_files("label")
@members = read_files("member")
@songs = read_files("song")
@bands = read_files("band")
@discs = read_files("disc")

output_items(@labels, "label")
output_items(@members, "member")
output_items(@songs, "song")
output_items(@bands, "band")
output_items(@discs, "disc")
output_index

puts @labels
puts @members
puts @songs
puts @bands
puts @discs
