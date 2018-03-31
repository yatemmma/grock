require "active_support/core_ext/string/inflections"
require "yaml"

module BinderRack
  module Core
    class Reader
      def read_dir(dir_name, clazz)
        data_list = Dir.glob("#{dir_name}/#{clazz.id}/*").inject({}) do |data, path|
          obj = read_item(clazz, path)
          data[obj.code] = obj
          data
        end

        Metadata.add_data(clazz.id, data_list)
        data_list
      end

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
