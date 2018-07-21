require "sinatra/activerecord/rake"
require "./models/_models"

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
end

task :import do
  require "./services/data_util"
  GROCK::DataUtil.import_all
end
