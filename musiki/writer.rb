require "erb"
require "fileutils"

class Writer
  def self.index
    output_html({}, "index", "index")
  end

  def self.page(items, name)
    output_html(items, name.pluralize, name.pluralize)
    items.each do |code, obj|
     output_html(obj, name, "#{name}/#{obj.code}")
    end
  end

  def self.output_html(obj, name, file)
    contents = File.read("musiki/templates/#{name}.erb")
    path = "docs/#{file}.html"
    FileUtils.mkdir_p(File.dirname(path))
    File.write(path, ERB.new(contents).result(binding))
  end
end
