require_relative "../../../core/data/generator"
require_relative "./head_helper"
require_relative "./url_helper"

module BinderRack
  module Core
    class Generator
      include GROCK::URLHelper
      include GROCK::HeadHelper
    end
  end
end
