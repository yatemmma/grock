module GROCK
  module MainContentsHelper
    def main_video_block(video)
      return nil if video.nil?

      html = <<-"EOS"
        <div id="player" data-key="#{video.youtube_key}"></div>
      EOS
    end

    def main_image_block(image)
      return nil if image.nil?

      html = <<-"EOS"
        <div class="image main-image" data-image="#{image.url}"><img></div>
      EOS
    end
  end
end
