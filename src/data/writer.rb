require "fileutils"
require "yaml"
require "./src/models/models"

module GROCK
  class Writer
    def write_item(object, path)
      FileUtils.mkdir_p(File.dirname(path))
      File.write(path, YAML.dump(object.metadata))
    end

    def write_items(objects, path)
      FileUtils.mkdir_p(File.dirname(path))
      data = objects.map {|object| object.metadata}
      File.write(path, YAML.dump(data))
    end
  end
end
