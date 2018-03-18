module ImageHelper
  def disc_image(level = 0)
    images.nil? ? "./#{"../"*level}assets/images/no_image.jpg" : disc.images.first
  end
end
