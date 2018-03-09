require "active_support/core_ext/string/inflections"
require "fileutils"
require "yaml"

class Updater

  def self.update(data, names)
    names.each do |name|
      items = data[name.to_sym]
      clazz = Object.const_get(name.camelize)
      items.each do |code, item|
        path = "updated/#{name}/#{name}##{item.code}.yaml"
        FileUtils.mkdir_p(File.dirname(path))

        diff = (item.contents.keys.map {|key| key.to_sym}) - clazz.attributes
        raise "mismatched keys:#{diff} on #{clazz}" unless diff.empty?

        hash_object = item.contents.to_a.each_with_object({}) do |obj, hash|
          hash[obj.first] = obj.last
        end
        contents = clazz.attributes.map do |attribute|
          [attribute.to_s, hash_object[attribute.to_s]]
        end
        YAML.dump(contents.to_h, File.open(path, "w"))
      end
    end
  end
end
