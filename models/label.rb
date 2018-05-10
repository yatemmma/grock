require "countries"

class Label < ActiveRecord::Base
	self.primary_key = :code

	class << self
		def site_keys
			%w(website wikipedia youtube twitter facebook)
		end

		def all_items
			self.order("name")
		end

		def search_json
			Label.all_items.map {|x|
				{
					code: x.code,
					name: x.name,
					country: x.origin,
					updated: x.updated_date 
				}
			}.to_json
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

	def twitter_key
		self.twitter.split(" ").first.split("/").last unless self.twitter.nil?
	end

	def youtube_key
		self.youtube.split(" ").first.split("/")[-2, 2] unless self.youtube.nil?
	end

	def main_image
		self.images.split(",").first unless self.images.nil?
	end

	def video_list
		list = self.videos
		list += ","
		list += Feed.where(owner: self.code).map {|x| x.youtube_video_key}.join(",")
		list.split(",").compact.reject { |c| c.empty? }.join(",")
	end

	def link_list
		self.links.nil? ? [] : self.links.split(",")
	end

	def updated_date
		self.updated_at.getlocal.strftime("%Y/%m/%d %H:%M:%S")
	end
end
