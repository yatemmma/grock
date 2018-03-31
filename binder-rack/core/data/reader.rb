require "yaml"

module BinderRack
  module Core
    class Reader
      def read_item(clazz, path)
        object = YAML.load_file(path)
        clazz.new(object)
      end

      def read_items(clazz, path)
        objects = YAML.load_file(path)
        objects.map do |object|
          clazz.new(object)
        end
      end
    end
  end
end
