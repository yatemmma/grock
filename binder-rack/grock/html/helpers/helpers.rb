require_relative "../../../core/data/generator"
require_relative "./head_helper"
require_relative "./url_helper"
require_relative "./header_footer_helper"
require_relative "./feed_helper"
require_relative "./main_contents_helper"
require_relative "./body_helper"
require_relative "./sns_helper"
require_relative "./contents_helper"
require_relative "./index_helper"
require_relative "./release_helper"

module BinderRack
  module Core
    class Generator
      include GROCK::URLHelper
      include GROCK::HeadHelper
      include GROCK::HeaderFooterHelper
      include GROCK::FeedHelper
      include GROCK::MainContentsHelper
      include GROCK::BodyHelper
      include GROCK::SNSHelper
      include GROCK::ContentsHelper
      include GROCK::IndexHelper
      include GROCK::ReleaseHelper
    end
  end
end
