require "sinatra/activerecord/rake"

task :app do
  require "./controllers/app"
  App.run!
end

task :build do

end

task :gen do
  require "./controllers/generator"
  Hoge.new.gen
end

task :crawl do
  # GROCK::Crawler.new.get_rss "https://www.theprp.com/feed/"
end

task :export do
  require "./services/data_util"
  GROCK::DataUtil.export_all
  # GROCK::Importer.export(:news_site)
end

task :import do
  # GROCK::Importer.import(:news_site)
end
