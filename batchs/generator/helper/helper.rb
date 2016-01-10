module Helper
  def template(template, param={})
    Slim::Template.new("templates/#{template}.html", {}).render(self, param)
  end

  def sub_template(template, param={})
    template("_#{template}", param)
  end

  def image_url(image)
  	image ||= "#{@page[:path]}/images/no_image.jpg"
  end
end
