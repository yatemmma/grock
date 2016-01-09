# http://localhost:9292/data/name

require 'yaml'
require 'erb'
require 'json'
require 'httpclient'

API_URI = ENV['API_URI'] || 'http://localhost:9292'
OUT_DIR = 'public'

clnt = HTTPClient.new
json = clnt.get("#{API_URI}/data/name").body
p JSON.parse(json)
hoge = JSON.parse(json)['name']

index_html = ERB.new(IO.read('templates/index.erb')).result(binding)
File.write("#{OUT_DIR}/index.html", index_html)
