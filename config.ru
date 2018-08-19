require "./app/app"
require "./admin/app"

use Rack::Auth::Basic do |username, password|
  username == ENV["BASIC_AUTH_USERNAME"] && password == ENV["BASIC_AUTH_PASSWORD"]
end

run Rack::URLMap.new("/" => App, "/admin" => Admin)
