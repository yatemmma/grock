require "erb"
require "opal"
require "rexml/document"

module HTMLGenerator
  def gen(contents, template_path, output_path)
    erb = ERB.new(File.read(template_path))
    text = erb.result(binding)

    doc = REXML::Document.new(text)
    doc.elements.each("html/body/script[@type='text/ruby']") do |element|
      js_code = Opal::Compiler.new(element.text).compile
      script_tag = REXML::Element.new("script")
      script_tag.add(REXML::CData.new(js_code))
      element.replace_with(script_tag)
    end

    doc = doc.to_s.gsub(/\<\!\[CDATA\[/, "//<![CDATA[")
                  .gsub(/\]\]\>/, "//]]>\n")

    File.write(output_path, doc)
  end
end
