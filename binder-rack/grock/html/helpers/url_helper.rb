module GROCK
  module URLHelper
    def link(path)
      layer = @options[:layer]
      "./#{"../"*layer}#{path}"
    end
  end
end
