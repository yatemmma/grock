# http://localhost:9292/data/name

require 'yaml'
require 'erb'
require 'json'
require 'httpclient'

def erb(file, binding)
  ERB.new(IO.read("templates/#{file}.erb")).result(binding)
end

API_URI = ENV['API_URI'] || 'http://localhost:9292'
OUT_DIR = 'public'

clnt = HTTPClient.new
json = clnt.get("#{API_URI}/data/labels").body
hoge = JSON.parse(json)['name']
