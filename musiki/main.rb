require "erb"
require "fileutils"
require "./musiki/metadata"

def read_files(dir)
  data = {}
  Dir.glob("src/#{dir}/*").each do |path|
    text = File.read(path)
    banddata = Metadata.new(text)
    data[banddata[:code]] = banddata
  end
  data
end

def output_html(obj, template, file)
  contents = File.read("musiki/templates/#{template}.erb")
  path = "output/#{file}.html"
  FileUtils.mkdir_p(File.dirname(path))
  File.write(path, ERB.new(contents).result(binding))
end

@labels = read_files("label")
@members = read_files("member")
@songs = read_files("song")
@bands = read_files("band")
@discs = read_files("disc")

@labels.each do |code, label|
  output_html(label, "label", "label/#{label[:code]}")
end

puts @labels
puts @members
puts @songs
puts @bands
puts @discs
