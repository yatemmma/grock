require "active_support/core_ext/string/inflections"
require "fileutils"
require "yaml"

class Updater

  def self.update(data, names)
    names.each do |name|
      items = data[name.to_sym]
      clazz = Object.const_get(name.camelize)
      p clazz
      items.each do |code, item|
        # obj = item.contents
        # contents = File.read("musiki/yaml_templates/#{name}.erb")
        # path = "updated/#{name}/#{name}##{item.code}.yaml"
        # FileUtils.mkdir_p(File.dirname(path))
        # File.write(path, ERB.new(contents).result(binding))
        path = "updated/#{name}/#{name}##{item.code}.yaml"
        FileUtils.mkdir_p(File.dirname(path))

        hash_object = item.contents.to_a.each_with_object({}) do |obj, hash|
          p obj, hash
          hash[obj.first] = obj.last
        end
        p 1111
        p hash_object
        p clazz.attributes
        contents = clazz.attributes.map { |attribute| [attribute.to_s, hash_object[attribute.to_s]] }
        p 2222
        p contents
        YAML.dump(contents.to_h, File.open(path, "w"))
      end
    end
  end
end
