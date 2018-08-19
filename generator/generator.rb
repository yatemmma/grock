require "rack/test"
require "./app/app"

class Hoge
  include Rack::Test::Methods

  def app
    App
  end

  def foo(path)
    get path
    p last_response.body
  end
end
