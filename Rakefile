task :start do
  system "bundle exec rackup"
end

task :migrate do
  database_url = ENV["DATABASE_URL"] || "sqlite://db/database.sqlite3"
  system "bundle exec sequel -m db/migrations #{database_url}"
end

task :generate do
  require "fileutils"
  require "./generator/generator"
  Dir.glob("docs/*") do |dir|
    p dir
    FileUtils.rm_r (dir) unless dir == "docs/assets"
  end
  File.write("docs/index.html", Hoge.new.foo("/"))
  File.write("docs/sites.html", Hoge.new.foo("/sites"))
end
