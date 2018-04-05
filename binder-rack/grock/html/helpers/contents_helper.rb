module GROCK
  module ContentsHelper
    def sub_video_block(video)
      return nil if (video.nil? || video.to_s.nil?)

      html = <<-"EOS"
        <div id="sub-player" data-key="#{video.youtube_key}"></div>
      EOS
    end

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
      path = "#{item.class.id}/#{item.code}.html"
      image = item.images.nil? ? '' : item.images.first

      words = []
      words << item.name.to_s
      words << "<div class='description'>(#{item.description.to_s})</div>" unless item.description.to_s.nil?

      html = <<-"EOS"
        <a class="block band" href="#{link path}">
          <div class="image" data-image="#{image}">
            <img>
          </div>
          <div class="label">#{label}</div>
          <div class="name">#{words.join(" ")}</div>
        </a>
      EOS
    end

    def disc_block(disc)
      return if disc.nil?

      path = "disc/#{disc.code}.html"
      title = disc.band?.name.to_s
      title += " - #{disc.type.short_name}" unless disc.type.short_name.nil?

      html = <<-"EOS"
        <a class="block disc" href="#{link path}">
          <div class="image" data-image="#{disc.images.first unless disc.images.nil?}">
            <img>
          </div>
          <div class="desc">#{disc.name}</div>
          <div class="desc">#{title}</div>
          <div class="desc">#{disc.date}</div>
        </a>
      EOS
    end

    def song_block(song)
      path = "song/#{song.code}.html"
      case song.type.to_s
      when "music_video"
        text = song.video_date.to_s
      when "guest"
        guest = song.guest(song.guests.first.code)
        text = "feat. #{guest.name}"
      end

      html = <<-"EOS"
        <a class="block song" href="#{link path}">
          <div class="image" data-image="#{song.youtube.youtube_thumbnail}">
            <img>
          </div>
          <div class="desc">#{song.type.name}:</div>
          <div class="desc">#{song.name.to_s}</div>
          <div class="desc">#{text}</div>
        </a>
      EOS
    end

    def link_block(item, key)
      if key.is_a? String
        link = item
        type = key
      else
        return unless item.respond_to?(key)
        link = item.send(key)
        return if link.empty?
        type = link.type_name(key.to_s)
      end

      html = <<-"EOS"
        <a class="block link" href="#{link.url}" target="_blank">
          <div class="type">#{type}</div>
          <div class="title">#{link.title || link.url}</div>
        </a>
      EOS
    end
  end
end
