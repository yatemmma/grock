require "sinatra/activerecord/rake"

task :app do
  require "./controllers/app"
  App.run!
end

task :build do

end

task :gen do

end

task :crawl do
  GROCK::Crawler.new.get_rss "https://www.theprp.com/feed/"
end

task :export do
  GROCK::Importer.export(:news_site)
end

task :import do
  GROCK::Importer.import(:news_site)
end

task :hoge do
  GROCK::FeedUrl.create(
    url: "https://chorus.fm/feed/"
  )
end
