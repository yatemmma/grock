require "./musiki/templates/helpers/head_helper"
require "./musiki/templates/helpers/header_footer_helper"
require "./musiki/templates/helpers/main_contents_helper"
require "./musiki/templates/helpers/body_helper"
require "./musiki/templates/helpers/contents_helper"

module HTMLHelper
  include AttributeHelper

  def link(path)
    "./#{"../"*@layer}#{path}"
  end

  def page_path(item)
    item.id + "/" + item.code + ".html"
  end

  def image_block(image_link, class_names)
    html = <<-"EOS"
      <div class="image #{class_names}" data-image="#{image_link}"><img></div>
    EOS
  end

  include HeadHTMLHelper
  include HeaderFooterHTMLHelper
  include MainContentsHTMLHelper
  include BodyHTMLHelper
  include ContentsHTMLHelper

  def origin_block(item)
    html = <<-"EOS"
      <div class="block origin" href="#">
        #{item.country_emoji} #{item.origin.nil? ? item.country_name : item.origin}
      </div>
    EOS
  end
end
