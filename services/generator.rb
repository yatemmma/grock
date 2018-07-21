require "./controllers/app"

require 'rack/test'

class Hoge
  include Rack::Test::Methods

  def app
    App
  end

  def gen
    get '/'
    p last_response.body
    File.write("docs/index.html", last_response.body)
  end
end
