require "countries"

class Label < ActiveRecord::Base
	self.primary_key = :code

	class << self
		def site_keys
			%w(website wikipedia youtube twitter facebook)
		end
	end

	def title
		self.name || ""
	end

	def country
		self.origin.split(" ").first unless self.origin.nil?
	end

	def country_name
		if (country.nil? || country.empty?)
			nil
		elsif country == "us"
			"USA"
		else
			c = ISO3166::Country.new(country)
			c.name
		end
	end

	def country_emoji
		if (country.nil? || country.empty?)
      nil
    else
      c = ISO3166::Country.new(country)
      c.emoji_flag
    end
	end

	def origin_full
		words = (self.origin || "").split(" ")
		words.shift
		words = [country_emoji] + words
		words.join(" ")
	end

	def feeds
		[]
	end

	def main_image
		self.images.split(",").first unless self.images.nil?
	end

	def link_list
		self.links.nil? ? [] : self.links.split(",")
	end
end
