require "erb"
require "fileutils"
require "./musiki/templates/helpers/helper"

class Writer
  extend HTMLHelper

  def self.index(output_dir)
    output_html({}, "index", "index", output_dir)
  end

  def self.page(items, name, output_dir)
    output_html(items, name.pluralize, name.pluralize, output_dir)
    items.each do |code, obj|
     output_html(obj, name, "#{name}/#{obj.code}", output_dir, 1)
    end
  end

  def self.output_html(obj, name, file, dir, layer = 0)
    @layer = layer
    @obj = obj
    contents = File.read("musiki/templates/#{name}.erb")
    path = "#{dir}/#{file}.html"
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, ERB.new(contents).result(binding))
  end
end
