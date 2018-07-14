require "active_support/core_ext/string/inflections"
require "sinatra/activerecord"
require "yaml"

config = YAML.load_file("db/database.yml")
ActiveRecord::Base.establish_connection(config["development"])

require_relative "./raw_feed"

module GROCK
  class Importer
    class << self
      def export(model_sym)
        clazz = Object.const_get("GROCK::#{model_sym.to_s.camelize}")
        yaml = clazz.all.map {|item| item.as_json}.to_yaml
        File.write("db/yaml/#{model_sym}.yml", yaml)
      end

      def import(model_sym)
        clazz = Object.const_get("GROCK::#{model_sym.to_s.camelize}")
        clazz.delete_all
        records = YAML.load_file("db/yaml/#{model_sym}.yml")
        records.each do |record|
          item = clazz.create(record)
          item.save
        end
      end
    end
  end
end
