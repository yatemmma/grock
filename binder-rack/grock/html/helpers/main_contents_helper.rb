module GROCK
  module MainContentsHelper
    def main_video_block(video)
      return nil if video.nil?

      html = <<-"EOS"
        <div id="player" data-key="#{video.youtube_key}"></div>
      EOS
    end
  end
end
