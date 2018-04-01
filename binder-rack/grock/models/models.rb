require_relative "./band"
require_relative "./label"
require_relative "./song"
require_relative "./disc"
require_relative "./member"

module BinderRack
  module Core
    class Metadata
      def plural?(text) #override
        return false if %w(wikipedia discogs).include?(text)
        text == text.pluralize
      end
    end
  end
end
