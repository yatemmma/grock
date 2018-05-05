require "erb"
require "opal"
require "rexml/document"

class OpalERB < ERB
  def result(_binding)
    text = super

    doc = REXML::Document.new(text)
    doc.elements.each("html/body/script[@type='text/ruby']") do |element|
      js_code = Opal::Compiler.new(element.text).compile
      script_tag = REXML::Element.new("script")
      script_tag.add(REXML::CData.new(js_code))
      element.replace_with(script_tag)
    end

    doc = doc.to_s.gsub(/\<\!\[CDATA\[/, "//<![CDATA[")
                  .gsub(/\]\]\>/, "//]]>\n")
  end
end

module ERBHelper
  def erb(name_sym, locals = {})
    @locals = locals
    template = OpalERB.new(File.read("templates/#{name_sym}.erb"))
    context = template.result(binding)

    template = ERB.new(File.read("templates/layout.erb"))
    text = template.result(binding)
  end

  def partial(name_sym, locals = {})
    @locals = locals
    template = OpalERB.new(File.read("templates/partials/#{name_sym}.erb"))
    context = template.result(binding)
  end

  def method_missing(method_sym, *args)
    if (not @locals.nil?) && @locals.has_key?(method_sym)
      @locals[method_sym] # refer locals on erb
    else
      super
    end
  end
end
