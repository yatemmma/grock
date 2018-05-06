require "net/http"
require "uri"

class Site
  class << self
    def get_title(url)
      p "get_title: #{url}"
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      req = Net::HTTP::Get.new(uri)
      req.add_field("Accept-Language", "en-US")
      res = http.start { |http| http.request req }
      res.body.match(/<title.*?>(.+)<\/title>/i)[1]
    end
  end
end
