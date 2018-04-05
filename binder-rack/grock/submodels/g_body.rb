module GROCK
  class GBody
    def initialize(data)
      @data = data
    end

    def html
      return nil if @data.nil?
      text = @data.gsub(/\[([^\]]*)\]\(([^\)]*)\)/) {"<a href='#{url($2)}' target='#{target($2)}'>#{$1}</a>"}
                  .split("\n")
                  .map {|x| "<p>#{x}</p>"}
                  .join
    end

    def target(link)
      link.start_with?("http") ? "_blank" : "_self"
    end

    def url(link)
      if link.start_with?("http") || link.start_with?(".")
        link
      else
        type, page = link.split("#")
        "../#{type}/#{page}.html"
      end
    end

    def to_s
      @data
    end
  end
end
