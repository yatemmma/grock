require "active_support/core_ext/string/inflections"
require "sinatra/activerecord"
require "yaml"

config = YAML.load_file("db/config/database.yml")
ActiveRecord::Base.establish_connection(config["development"])

require_relative "./band"
require_relative "./disc"
require_relative "./feed"
require_relative "./image"
require_relative "./label"
require_relative "./link"
require_relative "./site"
require_relative "./source"
require_relative "./tag"

module GROCK
  GENRES = [
    {value: "rock", display: "Rock"},
    {value: "post_hardcore", display: "Post-Hardcore"},
  ]

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
