require 'yaml'

class Band

	@@bands = nil

	def self.load
		puts "--info: band data loaded."
		raw_data = YAML.load_file('data/bands.yml')
		@@bands = raw_data.map {|key, value| [key, Band.new(key, value)]}.to_h
	end

	def self.all
		@@bands ||= load
	end

	def self.get_band(band_key)
		all[band_key.to_sym]
	end

	attr_reader :key, :name, :links

	def initialize(key, band)
		@key = key
		@name = band[:name]
		@links = band[:links] || {}
	end
end
