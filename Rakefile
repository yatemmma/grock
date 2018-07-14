require "sinatra/activerecord/rake"

require "./models/models"
require "./collectors/crawler"


task :crawl do
  GROCK::Crawler.new.get_rss "https://www.theprp.com/feed/"
end

task :export do
  GROCK::Importer.export(:raw_feed)
end

task :import do
  GROCK::Importer.import(:raw_feed)
end
