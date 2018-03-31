require "yaml"
require "./src/models/models"

module GROCK
  class Reader
    def read(clazz, path)
      objects = YAML.load_file(path)
      if objects.is_a? Array
        objects.map do |object|
          clazz.new(object)
        end
      else
        clazz.new(objects)
      end
    end
  end
end
