require "json"

module BinderRack
  module Core
    class Metadata
      attr_reader :metadata

      @@alldata = {}

      class << self
        def prop(sym, clazz=String)
          @properties ||= {}
          @properties[sym] = clazz
        end

        def props
          defined?(@properties) ? @properties.keys : []
        end

        def prop_type(sym)
          (@properties || {})[sym]
        end

        def id
          self.name.split('::').last.underscore
        end

        def add_data(key, data)
          @@alldata[key] = data
        end

        def alldata(key)
          @@alldata[key]
        end
      end

      def initialize(hash)
        @metadata = hash
      end

      def plural?(text)
        text == text.pluralize
      end

      def method_missing(method_sym, *args)
        # get property instance
        if self.class.props.include? method_sym
          data = @metadata[method_sym.to_s]

          if plural?(method_sym.to_s)
            return [] if data.nil?
            clazz = self.class.prop_type(method_sym)
            return data.map do |obj|
              clazz.new(obj)
            end
          else
            clazz = self.class.prop_type(method_sym)
            if data.nil? && clazz == String
              return nil
            else
              return clazz.new(data)
            end

          end
        end

        # ex. band?
        if method_sym.to_s.end_with?("?")
          method = method_sym.to_s[0..-2]
          data = self.class.alldata(method)
          if self.respond_to?(method) || (self.class.props.include? method.to_sym)
            return data[self.send(method)]
          end
        end

        super
      end
    end
  end
end
