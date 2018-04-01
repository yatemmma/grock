require_relative "../../../core/data/generator"
require_relative "./head_helper"
require_relative "./url_helper"
require_relative "./header_footer_helper"
require_relative "./feed_helper"

module BinderRack
  module Core
    class Generator
      include GROCK::URLHelper
      include GROCK::HeadHelper
      include GROCK::HeaderFooterHelper
      include GROCK::FeedHelper
    end
  end
end
