require "active_support/core_ext/string/inflections"
require "yaml"

module BinderRack
  module Core
    class Reader
      def read_dir(dir_name, clazz)
        data = Dir.glob("#{dir_name}/#{clazz.id}/*").inject({}) do |data, path|
          obj = read_item(clazz, path)
          data[obj.code] = obj
          data
        end

        Metadata.add_data(clazz.id, data)
        data
      end

      def read_item(clazz, path)
        object = YAML.load_file(path)
        clazz.new(object)
      end

      def read_dir_items(dir_name, clazz)
        data = Dir.glob("#{dir_name}/#{clazz.id}/*").inject({}) do |data, path|
          objects = read_items(clazz, path)
          objects.each do |obj|
            data[obj.code] = obj
          end
          data
        end

        Metadata.add_data(clazz.id, data)
        data
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
