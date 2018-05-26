require "countries"

module BaseModel
	def html_path
		"/#{self.class.to_s.downcase}/#{self.code}.html"
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

	def link_list
		self.links.nil? ? [] : self.links.split(",")
	end

	def updated_date
		self.updated_at.getlocal.strftime("%Y/%m/%d %H:%M:%S")
	end

  def video_list
    list = self.videos || ""
    list += ","
    list += Feed.where(owner: self.code).map {|x| x.youtube_video_key}.join(",")
    list.split(",").compact.reject { |c| c.empty? }.join(",")
  end
end

require_relative "./band"
require_relative "./disc"
require_relative "./feed"
require_relative "./label"
require_relative "./setting"
