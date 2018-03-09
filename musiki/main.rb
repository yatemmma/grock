require "fileutils"
require "./musiki/reader"
require "./musiki/updater"
require "./musiki/writer"

list = %w(member label song disc band)

# read files
@data = Reader.read(list)

# update metadata
FileUtils.rm_rf "updated"

Updater.update(@data, list)

# output html
FileUtils.rm_rf "output"

list.each do |name|
  Writer.page(@data[name.to_sym], name)
end
Writer.index

puts "---------------"
puts @data
