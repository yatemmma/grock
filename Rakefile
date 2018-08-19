task :start do
  system "bundle exec rackup"
end

task :migrate do
  system "bundle exec sequel -m db/migrations sqlite://db/database.sqlite3"
end
