module ContentsHTMLHelper
  def sns(item)
    url = DOMAIN + page_path(item)

    html = <<-"EOS"
      <div class="sns">
        <a href="#{twitter_share_link(url, item.title)}" target="_blank">
          <img src="#{link "assets/images/share_twitter.png"}">
        </a>
      </div>
    EOS
  end

  def info_block(item, key, class_names = "")
    return if item.nil?

    text = item.send(key)
    if text.nil?
      html = <<-"EOS"
        <div class="block admin #{class_names}">#{key}:#{text}</div>
      EOS
    else
      html = <<-"EOS"
        <div class="block #{class_names}">#{text}</div>
      EOS
    end
  end

  def band_block(item, label = "")
    image = item.images.nil? ? '' : item.images.first
    name = item.name
    name += item.description unless item.description.nil?

    html = <<-"EOS"
      <a class="block band" href="#{link page_path(item)}">
        <div class="image" data-image="#{image}">
          <img>
        </div>
        <div class="label">#{label}</div>
        <div class="name">#{item.name}</div>
      </a>
    EOS
  end

  def disc_block(disc)
    html = <<-"EOS"
      <a class="block disc" href="#{link page_path(disc)}">
        <div class="image" data-image="#{disc.images.first unless disc.images.nil?}">
          <img>
        </div>
        <div class="name">#{disc.name}</div>
        <div class="artist">#{disc.band?.name}</div>
        <div class="date">#{disc.date}</div>
      </a>
    EOS
  end

  def video_block(song)
    html = <<-"EOS"
      <a class="block song" href="#{link page_path(song)}">
        <div class="image" data-image="#{song.youtube_thmbnail}">
          <img>
        </div>
        <div class="name">#{song.song_type_name}</div>
        <div class="artist">#{song.name}</div>
        <div class="date">#{song.video_date}</div>
      </a>
    EOS
  end

  def link_block(item, key)
    type = link_type_name(key)
    data = item.send(key)
    links_block(data, type)
  end

  def links_block(data, type = nil)
    type_name = type || "Link"

    if data.nil?
      url = "https://www.google.co.jp/search?q=" + URI.encode_www_form_component(@obj.name + " " + type_name)
      html = <<-"EOS"
        <a class="block link admin" href="#{url}" target="_blank">
          <div class="type">#{type_name}</div>
          <div class="title"></div>
        </a>
      EOS
    else
      if data.is_a? Hash
        title = data["title"]
        url = data["url"]
      else
        title = data
        url = data
      end

      html = <<-"EOS"
        <a class="block link" href="#{url}" target="_blank">
          <div class="type">#{type_name}</div>
          <div class="title">#{title}</div>
        </a>
      EOS
    end

  end
end
