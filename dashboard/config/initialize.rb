require 'active_record'
require 'dotenv'
require 'config'

ENV['APP_ENV'] = ENV['APP_ENV'] ||= ENV['RACK_ENV'] ||= 'development'
Dotenv.load '.env_secret'

Config.load_and_set_settings("config/settings.yml", "config/environments/#{ENV['APP_ENV']}.yml")

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || Settings.database.to_h)
