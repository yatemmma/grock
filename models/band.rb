require "countries"
require "json"

class Band < ActiveRecord::Base
	self.primary_key = :code

	def all_links
		JSON.parse(links || "[]").reject {|x| x.nil? || x.empty?}
	end

	def all_feeds
		JSON.parse(feeds || "[]")
	end

	def title
		text = [name]
		text << "(#{active_short})" unless (active.nil? || active.empty?)
		text << "(#{description})" unless (description.nil? || description.empty?)
		text.join(" ")
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
		text = "#{country_emoji} #{origin}"
		text == " " ? "" : text
	end

	def active_full
		if (active.nil? || active.empty?)
      nil
    else
      text = (active[-1] == "-") ? "#{active}present" : active
    end
	end

	def active_short
		if (active.nil? || active.empty?)
      nil
    else
      text = active_full
      text.split("-").first.strip + "-" + text.split("-").last.strip
    end
	end

	def all_discs
		code.nil? ? [] : Disc.where("bands LIKE ?", "%#{code}%").all
	end

	def all_members
		code.nil? ? [] : Band.where("member_of LIKE ?", "%#{code}%").all
	end

	def all_ex_members
		code.nil? ? [] : Band.where("ex_member_of LIKE ?", "%#{code}%").all
	end
end
