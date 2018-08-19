task :start do
  system "bundle exec rackup"
end

task :migrate do
  system "bundle exec sequel -m db/migrations sqlite://db/database.sqlite3"
end

task :generate do
  require "./generator/generator"
  p 123
  File.write("docs/index.html", Hoge.new.foo("/"))
  File.write("docs/sites.html", Hoge.new.foo("/sites"))
end
