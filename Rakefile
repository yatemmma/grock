# bundle exec rackup

require 'rake'
require 'sequel'
require 'sequel/extensions/migration'
require 'yaml'

config = YAML.load_file("app/config/#{ENV['RAKE_ENV'] || 'development'}.yml")

namespace :db do
  # bundle exec sequel -m db/migrations sqlite://db/development.db
  desc "migrate database"
  task :migrate do
    DB = Sequel.connect(ENV['DATABASE_URL'] || config[:database])
    Sequel::Migrator.apply(DB, 'app/db/migrate')
  end
  
  task :init do
    system "sqlite3 app/db/development.db < app/db/development.sql"
  end
end
