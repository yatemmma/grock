module BinderRack
  module Core
    class Metadata
      attr_reader :metadata

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
