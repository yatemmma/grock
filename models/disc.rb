class Disc < ActiveRecord::Base
	self.primary_key = :code

	def all_links
		JSON.parse(links || "[]").reject {|x| x.nil? || x.empty?}
	end

	def all_feeds
		band_code = bands.split(",").first unless bands.nil?
		band = Band.find_by(code: band_code)
		band.nil? ? [] : JSON.parse(band.feeds || "[]")
	end

	def all_songs
		JSON.parse(songs || "[]").reject {|x| x.nil? || x.empty?}
	end

	def all_guests
		JSON.parse(guests || "[]").reject {|x| x.nil? || x.empty?}
	end

	def title
		name || ""
	end

	def band_name
		band_code = bands.split(",").first unless bands.nil?
		band = Band.find_by(code: band_code)
		band.nil? ? "" : band.name
	end

	def all_bands
		(bands || "").split(",").map{|x| Band.find_by(code: x)}
	end
end
