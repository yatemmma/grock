require "sequel"

DB = Sequel.connect( ENV["DATABASE_URL"] || "sqlite://db/database.sqlite3" )

p DB

class Site < Sequel::Model
end
