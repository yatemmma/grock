require "active_support"
require "./models/_models"

module GROCK
  class DataUtil
    class << self
      def export_all
        ActiveRecord::Base.connection.tables[2..-1].each do |table|
          self.export(table.singularize.to_sym)
        end
      end

      def export(model_sym)
        clazz = Object.const_get("GROCK::#{model_sym.to_s.camelize}")
        yaml = clazz.all.map {|item| item.as_json}.to_yaml
        File.write("db/yaml/#{model_sym}.yml", yaml)
      end

      def import_all
        ActiveRecord::Base.connection.tables[2..-1].each do |table|
          self.import(table.singularize.to_sym)
        end
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
