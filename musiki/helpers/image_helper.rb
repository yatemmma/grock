module ImageHelper
  def disc_image(level = 0)
    if images.nil?
      "./#{"../"*level}assets/images/no_image.jpg"
    elsif self.is_a?(Disc)
      images.first
    else
     disc.images.first
   end
  end
end
