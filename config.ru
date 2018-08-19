require "./admin/app"

$stdout.sync = true
run Sinatra::Application
