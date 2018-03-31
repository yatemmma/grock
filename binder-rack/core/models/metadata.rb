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

      def method_missing(method_sym, *args)
        if self.class.props.include? method_sym
          data = @metadata[method_sym.to_s]
          clazz = self.class.prop_type(method_sym)
          clazz.new(data)
        else
          super
        end
      end
    end
  end
end
