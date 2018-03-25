require "erb"
require "fileutils"
require "./musiki/templates/helpers/helper"

class Writer
  extend HTMLHelper

  def self.index
    output_html({}, "index", "index")
  end

  def self.page(items, name)
    output_html(items, name.pluralize, name.pluralize)
    items.each do |code, obj|
     output_html(obj, name, "#{name}/#{obj.code}", 1)
    end
  end

  def self.output_html(obj, name, file, layer = 0)
    @layer = layer
    contents = File.read("musiki/templates/#{name}.erb")
    path = "docs/#{file}.html"
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, ERB.new(contents).result(binding))
  end
end
