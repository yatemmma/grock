module GROCK
  module ContentsHelper
    def info_block(prop, class_names = "")
      if prop.nil?
        nil
      else
        html = <<-"EOS"
          <div class="block #{class_names}">#{prop.to_s}</div>
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

      if key.is_a? String
        url = item.url
        title = item.title
        type = key
      else
        link = item.send(key)
        return if link.empty?

        url = link.url
        title = link.title
        type = link.type_name(key.to_s)
      end

      html = <<-"EOS"
        <a class="block link" href="#{url}" target="_blank">
          <div class="type">#{type}</div>
          <div class="title">#{title || url}</div>
        </a>
      EOS
    end
  end
end
