require "erb"
# require "ruby2js"
# require "rexml/document"

class JSableERB < ERB
  def result(_binding)
    text = super

    # doc = REXML::Document.new(text)
    # doc.elements.each("html/body/script[@type='text/ruby']") do |element|
    #   js_code = Ruby2JS.convert(element.text)
    #   script_tag = REXML::Element.new("script")
    #   script_tag.add(REXML::CData.new(js_code))
    #   element.replace_with(script_tag)
    # end
    #
    # doc = doc.to_s.gsub(/\<\!\[CDATA\[/, "//<![CDATA[")
    #               .gsub(/\]\]\>/, "//]]>\n")
  end
end

module ERBHelper
  def link(path)
    "./#{"../"*@floor}#{path}"
  end

  def page_title(title)
    [title, "G-ROCK"].compact.join(" | ")
  end

  def erb(name, locals = {})
    @locals = locals
    template = JSableERB.new(File.read("templates/#{name}.erb"))
    context = template.result(binding)

    template = ERB.new(File.read("templates/layout.erb"))
    text = template.result(binding)
  end

  def partial(name, locals = {})
    @partial_locals = locals
    template = JSableERB.new(File.read("templates/partials/#{name}.erb"))
    context = template.result(binding)
  end

  def method_missing(method_sym, *args)
    # refer locals on erb
    if (not @locals.nil?) && @locals.has_key?(method_sym)
      @locals[method_sym]
    elsif (not @partial_locals.nil?) && @partial_locals.has_key?(method_sym)
      @partial_locals[method_sym]
    else
      super
    end
  end
end
