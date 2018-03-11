require "fileutils"
require "./musiki/reader"
require "./musiki/updater"
require "./musiki/writer"

list = %w(member label song disc band)

# read files
@data = Reader.read(list)

# update metadata
FileUtils.rm_rf "data2"

Updater.update(@data, list)

FileUtils.rm_rf "data"
FileUtils.move "data2", "data"

# output html
FileUtils.rm_rf "docs"

list.each do |name|
  Writer.page(@data[name.to_sym], name)
end
Writer.index

FileUtils.cp_r "musiki/assets", "docs"
