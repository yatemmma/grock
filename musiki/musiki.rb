require "fileutils"
require "yaml"
require "./musiki/reader"
require "./musiki/updater"
require "./musiki/writer"

module Musiki
  def self.gen
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
  end

  def self.band(name)
    p name
    code = name.downcase.gsub(" ", "_")
    path = "data/band/band##{code}.yaml"

    if File.exist? path
      p "already exist. #{path}"
      exit
    end
    FileUtils.mkdir_p(File.dirname(path))

    hash = {}
    Band.attributes.each do |key|
      hash[key.to_s] = nil
    end
    hash["code"] = code
    hash["name"] = name

    YAML.dump(hash, File.open(path, "w"))
  end
end
