require "active_support/core_ext/string/inflections"
require "sinatra/activerecord"
require "yaml"

config = YAML.load_file("db/config/database.yml")
ActiveRecord::Base.establish_connection(config["development"])

require_relative "./band"
require_relative "./disc"
require_relative "./feed"
require_relative "./image"
require_relative "./label"
require_relative "./link"
require_relative "./site"
require_relative "./source"
require_relative "./tag"
require_relative "./disc_band"
require_relative "./disc_label"
require_relative "./disc_disc"
require_relative "./band_band"
