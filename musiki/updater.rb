require "active_support/core_ext/string/inflections"
require "fileutils"
require "yaml"

class Updater

  def self.update(data, names)
    names.each do |name|
      items = data[name.to_sym]
      clazz = Object.const_get(name.camelize)

      if name == "disc" || name == "song"
        hash_by_band = {}
        items.each do |code, item|
          # path = "data2/#{name}/#{name}##{item.code}.yaml"
          # FileUtils.mkdir_p(File.dirname(path))

          diff = (item.contents.keys.map {|key| key.to_sym}) - clazz.attributes
          raise "mismatched keys:#{diff} on #{clazz}" unless diff.empty?

          hash_object = item.contents.to_a.each_with_object({}) do |obj, hash|
            hash[obj.first] = obj.last
          end
          contents = clazz.attributes.map do |attribute|
            [attribute.to_s, hash_object[attribute.to_s]]
          end.to_h
          # YAML.dump(contents.to_h, File.open(path, "w"))

          if hash_by_band.has_key? contents["band"]
            hash_by_band[contents["band"]] << contents
          else
            hash_by_band[contents["band"]] = [contents]
          end
        end

        hash_by_band.each do |band_name, contents_list|
          # p band_name, contents_list
          path = "data2/#{name}/#{name}##{band_name}.yaml"
          FileUtils.mkdir_p(File.dirname(path))
          YAML.dump(contents_list, File.open(path, "w"))
        end

      else
        items.each do |code, item|
          path = "data2/#{name}/#{name}##{item.code}.yaml"
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
end
