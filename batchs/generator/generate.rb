# http://localhost:9292/data/name

require 'yaml'
require 'erb'
require 'json'
require 'httpclient'
require 'slim'

require './helper/helper.rb'

include Helper

API_URI = ENV['API_URI'] || 'http://localhost:9292'
OUT_DIR = 'public'

def generate_labels_page
  clnt = HTTPClient.new
  json = clnt.get("#{API_URI}/data/labels").body
  labels = JSON.parse(json)
  @page = {:path => ".", :is_top => true, :labels => labels['items']}
  html = template :labels
  File.write("#{OUT_DIR}/labels.html", html)
end

generate_labels_page
