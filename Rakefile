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
    #DB = Sequel.connect('postgres://localhost/grock')
    Sequel::Migrator.apply(DB, './db/migrate')
  end
end

# namespace :db do
#   require "sequel"
#   namespace :migrate do
#     Sequel.extension :migration
#     # DB = Sequel.connect(ENV['DATABASE_URL'])
#     
#     config = YAML.load_file("config/#{ENV['RAKE_ENV'] || 'development'}.yml")
#     DB = Sequel.connect(config[:database])
# 
#     desc "Perform migration reset (full erase and migration up)"
#     task :reset do
#       Sequel::Migrator.run(DB, "migrations", :target => 0)
#       Sequel::Migrator.run(DB, "migrations")
#       puts "<= sq:migrate:reset executed"
#     end
# 
#     desc "Perform migration up/down to VERSION"
#     task :to do
#       version = ENV['VERSION'].to_i
#       raise "No VERSION was provided" if version.nil?
#       Sequel::Migrator.run(DB, "migrations", :target => version)
#       puts "<= sq:migrate:to version=[#{version}] executed"
#     end
# 
#     desc "Perform migration up to latest migration available"
#     task :up do
#       Sequel::Migrator.run(DB, "migrations")
#       puts "<= sq:migrate:up executed"
#     end
# 
#     desc "Perform migration down (erase all data)"
#     task :down do
#       Sequel::Migrator.run(DB, "migrations", :target => 0)
#       puts "<= sq:migrate:down executed"
#     end
#   end
# end
