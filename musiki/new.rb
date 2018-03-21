require "fileutils"
require "yaml"
require "./musiki/models/band"

band = ARGV.join(" ")
p band
code = band.downcase.gsub(" ", "_")
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
hash["name"] = band

YAML.dump(hash, File.open(path, "w"))
