# bundle exec rackup

require 'rake'
require 'sequel'
require 'sequel/extensions/migration'
require 'yaml'

namespace :db do
  # bundle exec sequel -m db/migrations sqlite://db/development.db
  desc "migrate database"
  task :migrate do
    config = YAML.load_file("config/#{ENV['RAKE_ENV'] || 'development'}.yml")
    DB = Sequel.connect(ENV['DATABASE_URL'] || config[:database])
    Sequel::Migrator.apply(DB, './db/migrate')
  end
end
