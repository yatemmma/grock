module GROCK
  module ReleaseHelper
    def releases(obj)
      discs = obj[Disc]
      sorted = discs.sort {|(k1, v1), (k2, v2)| v2.date <=> v1.date }
      index = sorted.index {|x| (x.last.date.to_x <=> Date.today.strftime("%Y/%m/%d")) < 0}
      num = [9, (index || 0)].max

      items = sorted[0..num].map {|x| release(x.last)}
      html = <<-"EOS"
        <div class="releases">
          #{items.join("\n")}
        </div>
      EOS
    end

    def release(disc)
      return if disc.nil?

      path = "disc/#{disc.code}.html"
      name = disc.name.to_s
      name += " - #{disc.type.short_name}" unless disc.type.short_name.nil?
      title = disc.band?.name.to_s
      title += " (#{disc.date})" unless disc.date.to_s.nil?

      html = <<-"EOS"
        <a class="release" href="#{link path}">
          <div class="image" data-image="#{disc.images.first unless disc.images.nil?}">
            <img>
          </div>
          <div class="desc">#{name}</div>
          <div class="desc">#{title}</div>
        </a>
      EOS
    end
  end
end
