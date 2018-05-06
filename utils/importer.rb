require "active_support/core_ext/string/inflections"
require "yaml"
require "./models/models"

class Importer
  class << self
    def export(model_sym)
      clazz = Object.const_get(model_sym.to_s.capitalize)
      yaml = clazz.all.map {|item| item.as_json}.to_yaml
      File.write("db/yaml/#{model_sym}.yml", yaml)
    end

    def import(model_sym)
      clazz = Object.const_get(model_sym.to_s.capitalize)
      clazz.delete_all
      records = YAML.load_file("db/yaml/#{model_sym}.yml")
      records.each do |record|
        record.delete("published_at")
        item = clazz.create(record)
        item.save
      end
    end
  end
end
