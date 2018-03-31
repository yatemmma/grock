module GROCK
  class Metadata
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

    def metadata
      @metadata
    end
  end
end
