require "./musiki/templates/helpers/head_helper"
require "./musiki/templates/helpers/header_footer_helper"
require "./musiki/templates/helpers/main_contents_helper"

module HTMLHelper
  include AttributeHelper

  def link(path)
    "./#{"../"*@layer}#{path}"
  end

  def image_block(image_link, class_names)
    html = <<-"EOS"
      <div class="image #{class_names}" data-image="#{image_link}"><img></div>
    EOS
  end

  include HeadHTMLHelper
  include HeaderFooterHTMLHelper
  include MainContentsHTMLHelper

  def body(text, l = 0)
    html = <<-"EOS"
      <div class="body">
        #{text}
      </div>
    EOS
  end

  def sns(path, title, level = 0)
    html = <<-"EOS"
      <div class="sns">
        <a href="#{twitter_share_link(DOMAIN + path, title)}" target="_blank">
          <img src="./#{"../"*level}assets/images/share_twitter.png">
        </a>
      </div>
    EOS
  end

  def band_block(label, band, path, level = 0)
    html = <<-"EOS"
      <a class="block band" href="./#{"../"*level}#{path}.html">
        <div class="image" data-image="#{band.images.nil? ? '' : band.images.first}">
          <img>
        </div>
        <div class="desc">
          <div class="label">
            #{label.nil? ? "" : label}
          </div>
          <div class="name">
            #{band.name} #{band.description.nil? ? "" : " (" + band.description + ")"}
         </div>
        </div>
      </a>
    EOS
  end

  def band_link(band, path, level = 0)
    band_block(nil, band, path, level)
  end

  def guest_link(label, band, path, level = 0)
    band_block(label, band, path, level)
  end

  def disc_block(disc, level = 0)
    html = <<-"EOS"
      <a class="block disc" href="./#{"../"*level}disc/#{disc.code}.html">
        <div class="image" data-image="#{disc.disc_image(level)}">
          <img>
        </div>
        <div class="desc">
          <div class="name">#{disc.name}</div>
          <div class="artist">#{disc.band?.name}</div>
          <div class="date">#{disc.date}</div>
        </div>
      </a>
    EOS
  end

  def video_block(song, level = 0)
    html = <<-"EOS"
      <a class="block song" href="./#{"../"*level}song/#{song.code}.html">
        <div class="image" data-image="#{song.youtube_thmbnail}">
          <img>
        </div>
        <div class="desc">
          <div class="name">#{song.type}</div>
          <div class="artist">#{song.name}</div>
          <div class="date">#{song.video_date}</div>
        </div>
      </a>
    EOS
  end

  def link_block(label, link)
    html = <<-"EOS"
      <a class="block link" href="#{link.is_a?(Hash) ? link["url"] : link}" target="_blank">
        <div class="type">#{label}</div>
        <div class="title">#{link.is_a?(Hash) ? link["title"] : link}</div>
      </a>
    EOS
  end

  def origin_block(item)
    html = <<-"EOS"
      <div class="block origin" href="#">
        #{item.country_emoji} #{item.origin.nil? ? item.country_name : item.origin}
      </div>
    EOS
  end
end
