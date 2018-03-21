require "fileutils"
require "yaml"

band = ARGV.join(" ")
p band
code = band.downcase.gsub(" ", "_")
path = "data/band/band##{code}.yaml"

if File.exist? path
  p "already exist. #{path}"
  exit
end

FileUtils.mkdir_p(File.dirname(path))
hash = {
  code: code,
  name: band
}
YAML.dump(hash, File.open(path, "w"))
