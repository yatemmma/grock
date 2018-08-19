require "./app/app"
require "./admin/app"

run Rack::URLMap.new("/" => App, "/admin" => Admin)
