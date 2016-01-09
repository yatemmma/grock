# bundle exec rackup
# bundle exec sequel -m db/migrations sqlite://db/test.db

require 'rake'
require 'sequel'
require 'sequel/extensions/migration'

namespace :db do
  desc "migrate database"
  task :migrate do
    DB = Sequel.connect(ENV['DATABASE_URL'] || "sqlite://db/test.db")
    Sequel::Migrator.apply(DB, './db/migrate')
  end
end
