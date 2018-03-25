module MainContentsHTMLHelper
  def main_youtube_block(key)
    html = <<-"EOS"
      <div id="player" data-key="#{key}"></div>
    EOS
  end

  def main_image_block(image)
    image_block(image, "main-image")
  end
end
